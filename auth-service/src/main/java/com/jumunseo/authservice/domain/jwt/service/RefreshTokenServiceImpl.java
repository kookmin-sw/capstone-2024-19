package com.jumunseo.authservice.domain.jwt.service;

import com.jumunseo.authservice.domain.jwt.dto.JwtTokenDto;
import com.jumunseo.authservice.domain.jwt.exception.RefreshTokenNotValidException;
import com.jumunseo.authservice.domain.jwt.redis.RefreshToken;
import com.jumunseo.authservice.domain.jwt.redis.RefreshTokenRedisRepository;
import com.jumunseo.authservice.domain.user.entity.Role;
import com.jumunseo.authservice.domain.user.entity.User;
import com.jumunseo.authservice.domain.user.exception.NotExistUserException;
import com.jumunseo.authservice.domain.user.repository.UserRepository;
import com.jumunseo.authservice.global.util.JwtTokenProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class RefreshTokenServiceImpl implements RefreshTokenService{

    private final UserRepository userRepository;
    private final JwtTokenProvider jwtTokenProvider;
    private final RefreshTokenRedisRepository refreshTokenRedisRepository;


    @Override
    public void updateRefreshToken(String Email, String uuid) {
        // 1. 사용자가 존재하는지 확인
        User user = userRepository.findByEmail(Email).orElseThrow(
                () -> new NotExistUserException("존재하지 않는 사용자입니다."));

        // 2. refreshToken 업데이트
        refreshTokenRedisRepository.save(RefreshToken.of(Email, uuid));
    }

    @Override
    public JwtTokenDto refreshAccessJwtToken(String accessToken, String refreshToken) {
        // 1. refreshToken이 있는지 확인
        User user = userRepository.findByEmail(jwtTokenProvider.getEmailForAccessToken(accessToken)).orElseThrow(
                () -> new NotExistUserException("존재하지 않는 사용자입니다."));
        RefreshToken refreshTokenEntity = refreshTokenRedisRepository.findById(user.getEmail()).orElseThrow(
                () -> new RefreshTokenNotValidException("레디스에 어세스 토큰에 맞는 리프레쉬 토큰이 없습니다."));
        // 2. refreshToken이 유효한지 확인

        // 2.1 refreshToKen 의 형식이 유효한가?
        if(!jwtTokenProvider.validateToken(refreshToken)){
            throw new RefreshTokenNotValidException("유효하지 않은 토큰입니다.");
        };
        // 2.2 받은 refreshToken이 레디스에 있는 refreshToken과 같은지 확인
        if(!jwtTokenProvider.sameRefreshToken(refreshToken,refreshTokenEntity.getRefreshTokenId())){
            throw new RefreshTokenNotValidException("레디스에 있는 토큰과 다릅니다.");
        }
        // 3. accessToken 업데이트
        Role role = user.getRole();
        String newAccessToken = jwtTokenProvider.createAccessToken(user.getEmail(), role.toString());
        return JwtTokenDto.builder()
                .accessToken(newAccessToken)
                .refreshToken(refreshToken)
                .accessTokenExpiredDate(jwtTokenProvider.getExpirationTime(newAccessToken))
                .build();
    }

    @Override
    public void logout(String accessToken) {
        if(!jwtTokenProvider.validateToken(accessToken)){
            throw new RefreshTokenNotValidException("유효하지 않은 토큰입니다.");
        }
        RefreshToken refreshToken = refreshTokenRedisRepository.findById(jwtTokenProvider.getEmailForAccessToken(accessToken)).orElseThrow(
                () -> new RefreshTokenNotValidException("레디스에 어세스 토큰에 맞는 리프레쉬 토큰이 없습니다."));

        refreshTokenRedisRepository.delete(refreshToken);
    }
}
