package com.jumunseo.authservice.domain.jwt.service;

public interface AccessTokenService {
    void CheckAccessToken(String authorizationHeader);
}
