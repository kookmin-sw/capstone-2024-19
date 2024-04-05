package com.jumunseo.authservice.domain.user.dto;

import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Builder
public class UpdateDto {
    private String email;
    private String name;
    private String accessToken;
    private String refreshToken;
}
