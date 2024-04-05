package com.jumunseo.authservice.global.config;

import com.jumunseo.authservice.domain.jwt.service.RefreshTokenService;
import com.jumunseo.authservice.global.security.AuthenticationFilter;
import com.jumunseo.authservice.global.util.CookieProvider;
import com.jumunseo.authservice.global.util.JwtTokenProvider;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.ProviderManager;
import org.springframework.security.authentication.dao.DaoAuthenticationProvider;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;


@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig {

    private final UserDetailsService userDetailsService;
    private final CorsConfig corsConfig;
    private final JwtTokenProvider jwtProvider;
    private final RefreshTokenService refreshTokenService;
    private final CookieProvider cookieProvider;
    private final PasswordEncoder bCryptPasswordEncoder;

    @Bean
    SecurityFilterChain filterChain(HttpSecurity http) throws Exception {
        // 0. 전처리
        AuthenticationFilter authenticationFilter
                = new AuthenticationFilter(authenticationManager(),jwtProvider,refreshTokenService,cookieProvider,bCryptPasswordEncoder);
        authenticationFilter.setFilterProcessesUrl("/login");

        // 1. 필터체인 생성
        http
            // 1.0. csrf 필터 비활성화
                .csrf(AbstractHttpConfigurer::disable)
            // 1.1. 인가 설정
                .authorizeHttpRequests((authorizeRequests) ->
                        authorizeRequests.anyRequest().permitAll())
            // 1.2. 세션 설정
                .sessionManagement((sessionManagement) ->
                        sessionManagement.sessionCreationPolicy(SessionCreationPolicy.STATELESS)) // 세션 사용 안함
            // 1.3. 로그아웃 설정
                .logout((logout) ->
                        logout.logoutUrl("/logout")
                                .deleteCookies("refreshToken"))
            // 1.4. Cors 필터
                .addFilter(corsConfig.corsFilter())
            // 1.5. Jwt 필터
                .addFilter(authenticationFilter);
        return http.build();
    }

    // with Standard Method
    // U.P.A.T. -> AuthenticationManager (ProviderManager)
    // ProviderManager -> AuthenticationProviders (DaoAuthenticationProvider)
    // DaoAuthenticationProvider -> UserDetailsService, PasswordEncoder
    @Bean
    public AuthenticationManager authenticationManager(){
        DaoAuthenticationProvider provider = new DaoAuthenticationProvider();
        provider.setPasswordEncoder(bCryptPasswordEncoder);
        provider.setUserDetailsService(userDetailsService);
        return new ProviderManager(provider);
    }
}
