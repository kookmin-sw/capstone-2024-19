package com.jumunseo.authservice.global.security;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.springframework.web.filter.OncePerRequestFilter;

import java.io.IOException;

// 인가 필터
// 일단 지금 상황에선 필요가 없다. 추후에 User 단에서 인가가 필요하면 추가 구현.
public class AuthorizationFilter  extends OncePerRequestFilter {

    // 로그인 받은 URI 설정
    private static final String LOGIN_URI = "/login";


    @Override
    protected void doFilterInternal(HttpServletRequest request, HttpServletResponse response, FilterChain filterChain)
            throws ServletException, IOException {

        // 만약 로그인이면 인가는 필요 없다.
        if(request.getServletPath().equals(LOGIN_URI)){
            filterChain.doFilter(request, response);
            return;
        }
        filterChain.doFilter(request, response);
    }
}
