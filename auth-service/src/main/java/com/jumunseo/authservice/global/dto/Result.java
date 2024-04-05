package com.jumunseo.authservice.global.dto;


import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
public class Result<T>{
    private Code code;
    private String message;
    private T data;

    @Builder
    public Result(Code code, String message, T data) {
        this.code = code;
        this.message = message;
        this.data = data;
    }

    // 앞의<T> -> 받는 타입
    // 뒤의<T> -> 반환하는 타입
    public static <T> Result<T> successResult(T data) {
        return Result.<T>builder()
                .code(Code.SUCCESS)
                .message("")
                .data(data)
                .build();
    }

    public static Result<?> failResult(String message) {
        return Result.builder()
                .code(Code.FAIL)
                .message(message)
                .data(null)
                .build();
    }
}
