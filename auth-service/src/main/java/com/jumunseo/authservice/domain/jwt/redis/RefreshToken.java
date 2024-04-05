package com.jumunseo.authservice.domain.jwt.redis;

// 리프래시 토큰을 레디스에 저장하는 클래스

import lombok.Getter;
import lombok.NoArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.data.annotation.Id;
import org.springframework.data.redis.core.RedisHash;

@NoArgsConstructor
@RedisHash(value = "refreshToken", timeToLive = 86400000) // 레디스에 저장될 해시 키
@Getter
public class RefreshToken {

    @Id
    private String userEmail; // 유저 아이디

    private String refreshTokenId; // 리프래시 토큰 아이디

    // 리프래시 토큰을 저장 가능한 형태로 변환
    public static RefreshToken of(String userEmail, String refreshTokenId) {
        RefreshToken token = new RefreshToken();
        token.userEmail = userEmail;
        token.refreshTokenId = refreshTokenId;
        return token;
    }
}
