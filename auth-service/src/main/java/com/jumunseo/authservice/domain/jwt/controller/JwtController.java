package com.jumunseo.authservice.domain.jwt.controller;

import com.jumunseo.authservice.domain.jwt.dto.JwtTokenDto;
import com.jumunseo.authservice.domain.jwt.service.AccessTokenService;
import com.jumunseo.authservice.domain.jwt.service.RefreshTokenService;
import com.jumunseo.authservice.global.dto.Result;
import com.jumunseo.authservice.global.util.CookieProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseCookie;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/auth")
@RequiredArgsConstructor
public class JwtController {

    private final CookieProvider cookieProvider;
    private final RefreshTokenService refreshTokenService;
    private final AccessTokenService accessTokenService;
    @GetMapping("/reissue")
    public ResponseEntity<Result<?>> refreshReissue(@RequestHeader("Authorization") String accessToken,
                                                    @CookieValue("refreshToken") String refreshToken) {
        // Access 재발급
        JwtTokenDto jwtTokenDto = refreshTokenService.refreshAccessJwtToken(accessToken,refreshToken);
        // 쿠키 재발급
        ResponseCookie responseCookie = cookieProvider.createRefreshTokenCookie(refreshToken);

        return ResponseEntity.ok().header(HttpHeaders.SET_COOKIE, responseCookie.toString())
                .body(Result.successResult(jwtTokenDto));
    }

    @GetMapping("/check-access-token")
    public ResponseEntity<Result<?>> checkAccessToken(@RequestHeader("Authorization") String accessToken) {
        accessTokenService.CheckAccessToken(accessToken);
        return ResponseEntity.ok(Result.successResult(null));
    }

    @GetMapping("/logout")
    public ResponseEntity<Result<?>> logout(@RequestHeader("Authorization") String accessToken) {
        // 레디스 삭제
        refreshTokenService.logout(accessToken);
        // 쿠키도 삭제
        ResponseCookie responseCookie = cookieProvider.deleteRefreshTokenCookie();

        return ResponseEntity.ok().header(HttpHeaders.SET_COOKIE, responseCookie.toString())
                .body(Result.successResult(null));
    }
}
