package com.jumunseo.authservice.domain.user.service;

import com.jumunseo.authservice.domain.jwt.exception.AccessTokenNotValidException;
import com.jumunseo.authservice.domain.jwt.service.RefreshTokenService;
import com.jumunseo.authservice.domain.user.dto.Mapper;
import com.jumunseo.authservice.domain.user.dto.SignupDto;
import com.jumunseo.authservice.domain.user.dto.UpdateDto;
import com.jumunseo.authservice.domain.user.dto.UserDto;
import com.jumunseo.authservice.domain.user.entity.User;
import com.jumunseo.authservice.domain.user.exception.DuplicateEmailException;
import com.jumunseo.authservice.domain.user.exception.NotExistUserException;
import com.jumunseo.authservice.domain.user.repository.UserRepository;
import com.jumunseo.authservice.global.util.JwtTokenProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService, UserDetailsService{

    private final UserRepository userRepository;
    private final Mapper mapper;
    private final JwtTokenProvider jwtTokenProvider;
    private final PasswordEncoder passwordEncoder;
    private final RefreshTokenService refreshTokenService;

    @Override
    public UserDto findUserById(Long Id) throws NotExistUserException{
        return mapper.toDto(userRepository.findById(Id).orElseThrow(
                () -> new NotExistUserException("User not found")));
    }

    @Override
    public UserDto findUserByEmail(String email) throws NotExistUserException{
        return mapper.toDto(userRepository.findByEmail(email).orElseThrow(
                () -> new NotExistUserException("User not found")));
    }


    @Override
    public void saveUser(SignupDto signupDto) throws DuplicateEmailException {
        if(userRepository.findByEmail(signupDto.getEmail()).isPresent()) {
            throw new DuplicateEmailException("Email already exists");
        }
        userRepository.save(mapper.toEntity(signupDto));
    }

    @Override
    public UserDto findUserByToken(String token) {
        try {
            jwtTokenProvider.validateToken(token);
        } catch (Exception e) {
            throw new AccessTokenNotValidException("not valid token");
        }
        return mapper.toDto(userRepository.findByEmail(jwtTokenProvider.getEmailForAccessToken(token)).orElseThrow(
                () -> new NotExistUserException("User not found")));
    }

    @Override
    public List<UserDto> findUsersByIds(List<Long> userIds) {
        List<User> users = new ArrayList<>();
        for(Long userId : userIds) {
            users.add(userRepository.findById(userId).orElseThrow(
                    () -> new NotExistUserException("User not found")));
        }
        return mapper.toDtoList(users);
    }

    // TODO: 유저 이름 or 이메일이 변경되면, Refresh 토큰, Access 토큰 재발급
    @Override
    public UpdateDto updateUser(String token, Map<String, String> updateInfo) {
        try {
            jwtTokenProvider.validateToken(token);
        } catch (Exception e) {
            throw new AccessTokenNotValidException("not valid token");
        }
        User originUser = userRepository.findByEmail(jwtTokenProvider.getEmailForAccessToken(token)).orElseThrow(
                () -> new NotExistUserException("User not found"));

        // 더티체킹 활용
        if(updateInfo.containsKey("email")) {
            originUser.setEmail(updateInfo.get("email"));
        }
        if(updateInfo.containsKey("password")) {
            originUser.setPassword(passwordEncoder.encode(updateInfo.get("password")));
        }
        if(updateInfo.containsKey("name")) {
            originUser.setName(updateInfo.get("name"));
        }

        // 새로운 토큰 발급
        String newAccessToken = jwtTokenProvider.createAccessToken(originUser.getEmail(), originUser.getRole().toString());
        String newRefreshToken = jwtTokenProvider.createRefreshToken();
        // 레디스에 저장된 토큰 업데이트
        refreshTokenService.updateRefreshToken(originUser.getEmail(), jwtTokenProvider.getRefreshTokenId(newRefreshToken));


        return UpdateDto.builder()
                .name(originUser.getName())
                .email(originUser.getEmail())
                .accessToken(newAccessToken)
                .refreshToken(newRefreshToken)
                .build();
    }

    @Override
    public void deleteUser(String token) {
        try {
            jwtTokenProvider.validateToken(token);
        } catch (Exception e) {
            throw new AccessTokenNotValidException("not valid token");
        }
        userRepository.deleteByEmail(jwtTokenProvider.getEmailForAccessToken(token));
    }

    @Override
    // Test Method
    public void deleteUserByEmail(String email) {
        userRepository.deleteByEmail(email);
    }


    // 기존 LoadUserByUsername 재정의, 로그인 시에 사용된다.
    // 로그인 시에 사용자 정보를 가져와서 Security의 User 객체로 만들어서 반환한다.
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        User user = userRepository.findByEmail(username).orElseThrow(
                () -> new NotExistUserException("User not found"));

        SimpleGrantedAuthority authority = new SimpleGrantedAuthority(user.getRole().toString());

        return org.springframework.security.core.userdetails.User.builder()
                .username(user.getEmail())
                .password(user.getPassword())
                .authorities(authority)
                .build();
    }
    @Override
    public boolean duplicateEmailCheck(String email) {
        return userRepository.findByEmail(email).isPresent();
    }
}
