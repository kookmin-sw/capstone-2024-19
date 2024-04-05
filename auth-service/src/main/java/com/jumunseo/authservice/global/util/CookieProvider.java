package com.jumunseo.authservice.global.util;

import jakarta.servlet.http.Cookie;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.ResponseCookie;
import org.springframework.stereotype.Component;

@Component
public class CookieProvider {

    @Value("${jwt.refresh_expiration}")
    private String refreshTokenExpireTime;

    // 리프레시 토큰을 쿠키에 저장
    public ResponseCookie createRefreshTokenCookie(String refreshToken) {
        return ResponseCookie.from("refreshToken", refreshToken)
                .httpOnly(true)
                .maxAge(Long.parseLong(refreshTokenExpireTime))
                .path("/")
                .build();
    }

    // 쿠키에 있는 리프레시 토큰 삭제
    public ResponseCookie deleteRefreshTokenCookie() {
        return ResponseCookie.from("refreshToken", null)
                .maxAge(0)
                .path("/")
                .build();

    }

    // 쿠키에 있는 리프레시 토큰 가져오기
    // ResponseCookie -> Cookie
    public Cookie of(ResponseCookie responseCookie) {
        Cookie cookie = new Cookie(responseCookie.getName(), responseCookie.getValue());
        cookie.setHttpOnly(responseCookie.isHttpOnly());
        cookie.setMaxAge((int) responseCookie.getMaxAge().getSeconds());
        cookie.setPath(responseCookie.getPath());
        return cookie;
    }
}
