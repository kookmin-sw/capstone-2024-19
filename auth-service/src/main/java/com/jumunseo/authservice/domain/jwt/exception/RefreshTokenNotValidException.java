package com.jumunseo.authservice.domain.jwt.exception;

import com.jumunseo.authservice.global.dto.Result;
import com.jumunseo.authservice.global.exception.CustomException;
import lombok.Getter;

@Getter
public class RefreshTokenNotValidException extends RuntimeException{
    private final Result<?> result;

    public RefreshTokenNotValidException(String message) {
        this.result = Result.failResult(message);
    }

}
