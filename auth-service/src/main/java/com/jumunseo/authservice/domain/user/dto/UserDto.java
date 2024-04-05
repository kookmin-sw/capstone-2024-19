package com.jumunseo.authservice.domain.user.dto;

import com.jumunseo.authservice.domain.user.entity.Role;
import lombok.Builder;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
@Builder
public class UserDto {
    private String email;
    private Role role;
    private String name;
}
