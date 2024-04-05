package com.jumunseo.authservice.domain.user.exception;

import com.jumunseo.authservice.global.exception.CustomException;
import org.springframework.http.HttpStatus;

public class DuplicateEmailException extends CustomException {
    public DuplicateEmailException(String message) {
        super(HttpStatus.CONFLICT, message);
    }
}
