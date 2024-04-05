package com.jumunseo.authservice.domain.jwt.service;

import com.jumunseo.authservice.domain.jwt.dto.JwtTokenDto;

public interface RefreshTokenService {
    void updateRefreshToken(String Email, String uuid);
    JwtTokenDto refreshAccessJwtToken(String accessToken, String refreshToken);
    void logout(String accessToken);
}
