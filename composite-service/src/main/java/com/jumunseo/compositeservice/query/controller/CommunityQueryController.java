package com.jumunseo.compositeservice.query.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.jumunseo.compositeservice.global.exception.Result;
import com.jumunseo.compositeservice.global.exception.WebClient4xxException;
import com.jumunseo.compositeservice.global.exception.WebClient5xxException;
import com.jumunseo.compositeservice.query.internal.BoardResponseAdditionDto;
import com.jumunseo.compositeservice.query.internal.BoardResponseDto;
import com.jumunseo.compositeservice.query.internal.DebateSummary;
import com.jumunseo.compositeservice.query.internal.MagicianChat;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.json.simple.JSONObject;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.reactive.function.client.WebClient;
import reactor.core.publisher.Mono;

import java.util.Map;

@RequiredArgsConstructor
@Controller
@RequestMapping("/query/community")
@Tag(name = "Community Query", description = "커뮤니티 서비스를 위한 쿼리 컨트롤러")
public class CommunityQueryController {
    @Value("${address.community}")
    private String COMMUNITY_URL;
    private final WebClient webClient;
    private final DebateQueryController debateQueryController;
    private final MagicianQueryController magicianQueryController;
    private final ObjectMapper objectMapper;

    // 커뮤니티 목록 조회
    @GetMapping("/list/{index}")
    @Tag(name = "Community Query")
    @Operation(summary = "Community List", description = "커뮤니티 목록 조회")
    private ResponseEntity<Result<?>> getCommunityList(@PathVariable Long index) {
        Mono<JSONObject> mono = webClient.get()
                .uri(COMMUNITY_URL +"/community/board/list/" + index)
                .retrieve()
                // 4-- 에러 -> 요청 오류
                .onStatus(HttpStatusCode::is4xxClientError, res -> Mono.error(
                        new WebClient4xxException(res.bodyToMono(String.class).toString())
                ))
                // 5-- 에러 -> 시스템 오류
                .onStatus(HttpStatusCode::is5xxServerError, res -> Mono.error(
                        new WebClient5xxException(res.bodyToMono(String.class).toString())
                ))
                .bodyToMono(JSONObject.class);
        return ResponseEntity.ok(Result.successResult(mono.block().get("data")));
    }

    // 커뮤니티 목록 조회 with 카테고리
    // 토큰 필요 X
    @GetMapping("/list/{category}/{index}")
    @Tag(name = "Community Query")
    @Operation(summary = "Community List with Category", description = "카테고리별 커뮤니티 목록 조회")
    private ResponseEntity<Result<?>> getCommunityListWithCategory(@PathVariable String category, @PathVariable Long index) {
        Mono<JSONObject> mono = webClient.get()
                .uri(COMMUNITY_URL +"/community/board/list/" + category + "/" + index)
                .retrieve()
                // 4-- 에러 -> 요청 오류
                .onStatus(HttpStatusCode::is4xxClientError, res -> Mono.error(
                        new WebClient4xxException(res.bodyToMono(String.class).toString())
                ))
                // 5-- 에러 -> 시스템 오류
                .onStatus(HttpStatusCode::is5xxServerError, res -> Mono.error(
                        new WebClient5xxException(res.bodyToMono(String.class).toString())
                ))
                .bodyToMono(JSONObject.class);
        return ResponseEntity.ok(Result.successResult(mono.block().get("data")));
    }
    // 커뮤니티 목록(사진) 조회
    @GetMapping("/list/photo/{index}")
    @Tag(name = "Community Query")
    @Operation(summary = "Community List With Photo", description = "커뮤니티 목록 + 사진 조회")
    private ResponseEntity<Result<?>> getCommunityPhotoList(@PathVariable Long index) {
        Mono<JSONObject> mono = webClient.get()
                .uri(COMMUNITY_URL +"/community/board/list/photo/" + index)
                .retrieve()
                // 4-- 에러 -> 요청 오류
                .onStatus(HttpStatusCode::is4xxClientError, res -> Mono.error(
                        new WebClient4xxException(res.bodyToMono(String.class).toString())
                ))
                // 5-- 에러 -> 시스템 오류
                .onStatus(HttpStatusCode::is5xxServerError, res -> Mono.error(
                        new WebClient5xxException(res.bodyToMono(String.class).toString())
                ))
                .bodyToMono(JSONObject.class);
        return ResponseEntity.ok(Result.successResult(mono.block().get("data")));
    }

    // 커뮤니티 목록(사진) 조회 with 카테고리
    // 토큰 필요 X
    @GetMapping("/list/photo/{category}/{index}")
    @Tag(name = "Community Query")
    @Operation(summary = "Community List with Photo With Category", description = "카테고리별 커뮤니티 목록 조회")
    private ResponseEntity<Result<?>> getCommunityPhotoListWithCategory(@PathVariable String category, @PathVariable Long index) {
        Mono<JSONObject> mono = webClient.get()
                .uri(COMMUNITY_URL +"/community/board/list/photo/" + category + "/" + index)
                .retrieve()
                // 4-- 에러 -> 요청 오류
                .onStatus(HttpStatusCode::is4xxClientError, res -> Mono.error(
                        new WebClient4xxException(res.bodyToMono(String.class).toString())
                ))
                // 5-- 에러 -> 시스템 오류
                .onStatus(HttpStatusCode::is5xxServerError, res -> Mono.error(
                        new WebClient5xxException(res.bodyToMono(String.class).toString())
                ))
                .bodyToMono(JSONObject.class);
        return ResponseEntity.ok(Result.successResult(mono.block().get("data")));
    }

    // 커뮤니티 상세 조회 -> 마법사 or 토론 요약 or 바닐라
    // 토큰 필요 X
    // 하지만 email 필요
    @GetMapping("/detail/{id}")
    @Tag(name = "Community Query")
    @Operation(summary = "Community Detail", description = "커뮤니티 상세 조회")
    private ResponseEntity<Result<?>> getCommunityDetail(@PathVariable Long id, HttpServletRequest req) throws JsonProcessingException {
        String email = (String) req.getAttribute("email");
        if (email == null) {
            email = "UNSIGNED";
        }

        Mono<JSONObject> mono = webClient.get()
                .uri(COMMUNITY_URL +"/community/board/detail/" + id)
                .header("email", email)
                .retrieve()
                // 4-- 에러 -> 요청 오류
                .onStatus(HttpStatusCode::is4xxClientError, res -> Mono.error(
                        new WebClient4xxException(res.bodyToMono(String.class).toString())
                ))
                // 5-- 에러 -> 시스템 오류
                .onStatus(HttpStatusCode::is5xxServerError, res -> Mono.error(
                        new WebClient5xxException(res.bodyToMono(String.class).toString())
                ))
                .bodyToMono(JSONObject.class);

        Map<String,Object> mapObject = (Map<String, Object>) mono.block().get("data");
        BoardResponseDto boardResponseDto = objectMapper.convertValue(mapObject, BoardResponseDto.class);

        if (boardResponseDto.getCategory().equals("MAGICIAN")) {
            Map<String,Object> chat = (Map<String,Object>) magicianQueryController.get_by_roomId_method(req, boardResponseDto.getDataId());
            MagicianChat magicianChat = objectMapper.convertValue(chat, MagicianChat.class);
            BoardResponseAdditionDto boardResponseAdditionDto = BoardResponseAdditionDto.builder()
                    .data(magicianChat)
                    .boardResponseDto(boardResponseDto)
                    .build();
            return ResponseEntity.ok(Result.successResult(boardResponseAdditionDto));
        }
        else if (boardResponseDto.getCategory().equals("SUMMARY")) {
            Map<String,Object> debate = (Map<String,Object>) debateQueryController.get_chat_summary_method(req, Long.valueOf(boardResponseDto.getDataId()));
            DebateSummary debateSummary = objectMapper.convertValue(debate.get("data"), DebateSummary.class);
            BoardResponseAdditionDto boardResponseAdditionDto = BoardResponseAdditionDto.builder()
                    .data(debateSummary)
                    .boardResponseDto(boardResponseDto)
                    .build();
            return ResponseEntity.ok(Result.successResult(boardResponseAdditionDto));
        }
        else {
            return ResponseEntity.ok(Result.successResult(boardResponseDto));

        }
    }

    // 좋아요 여부 조회
    // 토큰 필요
    @GetMapping("/like/{board_id}")
    @Tag(name = "Community Query")
    @Operation(summary = "Like Check", description = "좋아요 여부 조회")
    private ResponseEntity<Result<?>> getLike(HttpServletRequest req, @PathVariable Long board_id) {
        Mono<JSONObject> mono = webClient.get()
                .uri(COMMUNITY_URL +"/community/board/like/" + board_id)
                .header("email", req.getAttribute("email").toString())
                .retrieve()
                // 4-- 에러 -> 요청 오류
                .onStatus(HttpStatusCode::is4xxClientError, res -> Mono.error(
                        new WebClient4xxException(res.bodyToMono(String.class).toString())
                ))
                // 5-- 에러 -> 시스템 오류
                .onStatus(HttpStatusCode::is5xxServerError, res -> Mono.error(
                        new WebClient5xxException(res.bodyToMono(String.class).toString())
                ))
                .bodyToMono(JSONObject.class);
        return ResponseEntity.ok(Result.successResult(mono.block().get("data")));
    }


    // 댓글 리스트 조회
    // 토큰 필요 X
    @GetMapping("/comment/list/{id}")
    @Tag(name = "Community Query")
    @Operation(summary = "Comment List", description = "댓글 리스트 조회")
    private ResponseEntity<Result<?>> getCommentList(@PathVariable Long id, HttpServletRequest req) {
        Mono<JSONObject> mono = webClient.get()
                .uri(COMMUNITY_URL +"/community/comment/list/" + id)
                .retrieve()
                // 4-- 에러 -> 요청 오류
                .onStatus(HttpStatusCode::is4xxClientError, res -> Mono.error(
                        new WebClient4xxException(res.bodyToMono(String.class).toString())
                ))
                // 5-- 에러 -> 시스템 오류
                .onStatus(HttpStatusCode::is5xxServerError, res -> Mono.error(
                        new WebClient5xxException(res.bodyToMono(String.class).toString())
                ))
                .bodyToMono(JSONObject.class);
        return ResponseEntity.ok(Result.successResult(mono.block().get("data")));
    }
}
