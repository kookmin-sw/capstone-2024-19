package com.jumunseo.authservice.domain.user.dto;

import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class SignupDto {
    private String email;
    private String password;
    private String name;
}
