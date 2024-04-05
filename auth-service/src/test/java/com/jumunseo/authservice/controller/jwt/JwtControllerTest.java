package com.jumunseo.authservice.controller.jwt;

import com.jumunseo.authservice.domain.jwt.controller.JwtController;
import com.jumunseo.authservice.domain.jwt.redis.RefreshTokenRedisRepository;
import com.jumunseo.authservice.domain.jwt.service.RefreshTokenService;
import com.jumunseo.authservice.domain.user.dto.SignupDto;
import com.jumunseo.authservice.domain.user.dto.UserDto;
import com.jumunseo.authservice.domain.user.exception.NotExistUserException;
import com.jumunseo.authservice.domain.user.service.UserService;
import com.jumunseo.authservice.global.dto.Code;
import com.jumunseo.authservice.global.util.CookieProvider;
import com.jumunseo.authservice.global.util.JwtTokenProvider;
import jakarta.servlet.http.Cookie;
import org.junit.jupiter.api.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.autoconfigure.web.servlet.AutoConfigureMockMvc;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.http.ResponseCookie;
import org.springframework.test.context.ActiveProfiles;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.ResultActions;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.transaction.annotation.Transactional;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.*;


@SpringBootTest
@AutoConfigureMockMvc
@ActiveProfiles("test")
public class JwtControllerTest {
    @Autowired
    private MockMvc mockMvc;
    @Autowired
    private JwtController jwtController;
    @Autowired
    private JwtTokenProvider jwtTokenProvider;
    @Autowired
    private UserService userService;
    @Autowired
    private RefreshTokenService refreshTokenService;
    @Autowired
    private CookieProvider cookieProvider;
    @Autowired
    private RefreshTokenRedisRepository refreshTokenRedisRepository;

    @BeforeEach
    void setUp() {
        // 테스트 세팅
        SignupDto testUser = new SignupDto();
        testUser.setEmail("Test");
        testUser.setPassword("Test");
        testUser.setName("Test");
        userService.saveUser(testUser);
    }

    @AfterEach
    void tearDown() {
        // 테스트 종료
        try{
            userService.deleteUserByEmail("Test");
        }
        catch (NotExistUserException ignored) {
        }
    }

    @Test
    @DisplayName("토큰 갱신 테스트")
    @Transactional
    //Get Test
    void reissueToken() throws Exception {
        // GIVEN
        UserDto testUser = userService.findUserByEmail("Test");
        String accessToken = jwtTokenProvider.createAccessToken("Test", testUser.getRole().toString());
        String refreshToken = jwtTokenProvider.createRefreshToken();

        // 인증절차 따라하기
        refreshTokenService.updateRefreshToken("Test", jwtTokenProvider.getRefreshTokenId(refreshToken));

        // 쿠키에 refresh 토큰 저장
        ResponseCookie responseRefreshCookie = cookieProvider.createRefreshTokenCookie(refreshToken);
        Cookie cookie = cookieProvider.of(responseRefreshCookie);

        // WHEN
        ResultActions resultActions = mockMvc.perform(MockMvcRequestBuilders.get("/auth/reissue")
                .cookie(cookie)
                .header("Authorization", accessToken)
                .contentType("application/json"));

        // THEN
        resultActions.andExpect(status().isOk())
                .andExpect(jsonPath("code").value(Code.SUCCESS.name()))
                .andExpect(jsonPath("message").value(""))
                .andExpect(jsonPath("data.accessToken").exists())
                .andExpect(jsonPath("data.refreshToken").exists())
                .andExpect(jsonPath("data.accessTokenExpiredDate").exists())
                .andExpect(header().exists("Set-Cookie"))
                .andExpect(cookie().exists("refreshToken"));
    }

    @Test
    @DisplayName("로그아웃 테스트")
    @Transactional
    //Get Test
    void logout() throws Exception {
        // GIVEN
        UserDto testUser = userService.findUserByEmail("Test");
        String accessToken = jwtTokenProvider.createAccessToken("Test", testUser.getRole().toString());
        String refreshToken = jwtTokenProvider.createRefreshToken();

        // 인증절차 따라하기, 레디스에 저장 -> 로그인이 되었다고 판단.
        refreshTokenService.updateRefreshToken("Test", jwtTokenProvider.getRefreshTokenId(refreshToken));

        // 쿠키에 refresh 토큰 저장
        ResponseCookie responseRefreshCookie = cookieProvider.createRefreshTokenCookie(refreshToken);
        Cookie cookie = cookieProvider.of(responseRefreshCookie);

        // WHEN
        ResultActions resultActions = mockMvc.perform(MockMvcRequestBuilders.get("/auth/logout")
                .cookie(cookie)
                .header("Authorization", accessToken)
                .contentType("application/json"));

        // THEN
        resultActions.andExpect(status().isOk())
                .andExpect(jsonPath("code").value(Code.SUCCESS.name()))
                .andExpect(jsonPath("message").value(""))
                .andExpect(jsonPath("data").isEmpty())
                .andExpect(header().exists("Set-Cookie"));

        // 레디스 저장소 삭제 확인
        Assertions.assertNull(refreshTokenRedisRepository.findById("Test").orElse(null));
    }
}
