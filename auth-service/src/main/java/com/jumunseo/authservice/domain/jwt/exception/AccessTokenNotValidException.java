package com.jumunseo.authservice.domain.jwt.exception;

import com.jumunseo.authservice.global.exception.CustomException;
import org.springframework.http.HttpStatus;

public class AccessTokenNotValidException extends CustomException {
    public AccessTokenNotValidException(String message) {
        super(HttpStatus.UNAUTHORIZED, message);
    }
}
