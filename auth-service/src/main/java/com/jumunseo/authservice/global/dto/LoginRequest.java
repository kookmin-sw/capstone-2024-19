package com.jumunseo.authservice.global.dto;

import lombok.Getter;

@Getter
public class LoginRequest {
    private String email;
    private String password;
}
