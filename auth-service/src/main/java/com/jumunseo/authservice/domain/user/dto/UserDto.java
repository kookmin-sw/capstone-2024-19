package com.jumunseo.authservice.domain.user.dto;

import com.jumunseo.authservice.domain.user.entity.Role;
import lombok.Getter;
import lombok.Setter;

@Setter
@Getter
public class UserDto {
    String email;
    Role role;
}