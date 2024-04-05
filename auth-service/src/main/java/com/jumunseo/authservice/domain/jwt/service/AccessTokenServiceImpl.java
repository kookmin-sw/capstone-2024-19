package com.jumunseo.authservice.domain.jwt.service;

import com.jumunseo.authservice.domain.jwt.exception.AccessTokenNotValidException;
import com.jumunseo.authservice.global.util.JwtTokenProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

@Service
@RequiredArgsConstructor
public class AccessTokenServiceImpl implements AccessTokenService{
    private final JwtTokenProvider jwtTokenProvider;


    @Override
    public void CheckAccessToken(String authorizationHeader) {
        String token = authorizationHeader.replace("Bearer ", "");

        if (!jwtTokenProvider.validateToken(token)) {
            throw new AccessTokenNotValidException("유효하지 않은 토큰입니다.");
        }
    }
}
