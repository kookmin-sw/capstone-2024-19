package com.jumunseo.authservice.domain.user.controller;

import com.jumunseo.authservice.domain.jwt.dto.JwtTokenDto;
import com.jumunseo.authservice.domain.jwt.service.RefreshTokenService;
import com.jumunseo.authservice.domain.user.dto.SignupDto;
import com.jumunseo.authservice.domain.user.dto.UpdateDto;
import com.jumunseo.authservice.domain.user.dto.UserDto;
import com.jumunseo.authservice.global.dto.Result;
import com.jumunseo.authservice.domain.user.service.UserService;
import com.jumunseo.authservice.global.util.CookieProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseCookie;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import jakarta.validation.Valid;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/user")
@RequiredArgsConstructor
public class UserController {

    private final UserService userService;
    private final CookieProvider cookieProvider;

    // 토큰으로 유저 정보 가져오기
    @GetMapping("/info")
    public ResponseEntity<Result<?>> getUserInfoByToken(@RequestHeader("Authorization") String authorizationHeader){
        return ResponseEntity.ok(Result.successResult(userService.findUserByToken(authorizationHeader)));
    }

    // 유저 아이디로 유저 정보 가져오기
    @GetMapping("/info/{userId}")
    public ResponseEntity<Result<?>> getUserInfoByUserId(@PathVariable Long userId) {
        return ResponseEntity.ok(Result.successResult(userService.findUserById(userId)));
    }

    // 이메일로 유저 정보 가져오기
    @GetMapping("/info/email/{email}")
    public ResponseEntity<Result<?>> getUserInfoByEmail(@PathVariable String email) {
        return ResponseEntity.ok(Result.successResult(userService.findUserByEmail(email)));
    }

    // 바디에 유저 아이디 리스트를 넣어서 유저 정보를 가져올 수 있게
    @GetMapping("/info/users/{userIds}")
    public ResponseEntity<Result<?>> getUserInfoByUserIds(@PathVariable List<Long> userIds) {
        return ResponseEntity.ok(Result.successResult(userService.findUsersByIds(userIds)));
    }

    // 토큰으로 유저 정보 수정
    @PutMapping("/update")
    public ResponseEntity<Result<?>> updateUserInfo(@RequestHeader("Authorization") String authorizationHeader,
                                                    @CookieValue("refreshToken") String refreshToken,
                                                    @RequestBody Map<String,String> updateInfo) {

        UpdateDto updateDto = userService.updateUser(authorizationHeader, updateInfo);
        ResponseCookie responseCookie = cookieProvider.createRefreshTokenCookie(updateDto.getRefreshToken());

        return ResponseEntity.ok().header(HttpHeaders.SET_COOKIE, responseCookie.toString())
                .body(Result.successResult(updateDto));
    }

    // 토큰으로 유저 정보 삭제
    @DeleteMapping("/delete")
    public ResponseEntity<Result<?>> deleteUserInfo(@RequestHeader("Authorization") String authorizationHeader) {
        userService.deleteUser(authorizationHeader);
        return ResponseEntity.ok(Result.successResult(null));
    }

    // 회원가입
    @PostMapping("/signup")
    public ResponseEntity<Result<?>> signUp(@Valid @RequestBody SignupDto signupDto) {
        userService.saveUser(signupDto);
        return ResponseEntity.status(HttpStatus.CREATED).body(Result.successResult(null));
    }

    // 이메일 중복 체크
    @GetMapping("/duplicate/{email}")
    public ResponseEntity<Result<?>> checkDuplicateEmail(@PathVariable String email) {
        return ResponseEntity.ok(Result.successResult(userService.duplicateEmailCheck(email)));
    }
}
