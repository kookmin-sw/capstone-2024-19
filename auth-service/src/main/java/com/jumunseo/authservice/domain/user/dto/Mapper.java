package com.jumunseo.authservice.domain.user.dto;

import com.jumunseo.authservice.domain.user.entity.Role;
import com.jumunseo.authservice.domain.user.entity.User;
import lombok.RequiredArgsConstructor;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
@RequiredArgsConstructor
public class Mapper {

    private final PasswordEncoder passwordEncoder;

    // User 객체를 UserDto 객체로 변환한다.
    public UserDto toDto(User user) {
        return UserDto.builder()
                .email(user.getEmail())
                .role(user.getRole())
                .name(user.getName())
                .build();
    }

    // 회원가입 시에 사용자 정보를 User 객체로 만들어서 반환한다.
    public User toEntity(SignupDto signupDto) {
        return User.builder()
                .email(signupDto.getEmail())
                .password(passwordEncoder.encode(signupDto.getPassword()))
                .name(signupDto.getName())
                .role(Role.USER)
                .build();
    }

    public List<UserDto> toDtoList(List<User> users) {
        List<UserDto> userDtos = new ArrayList<>();
        for (User user : users) {
            userDtos.add(toDto(user));
        }
        return userDtos;
    }

}
