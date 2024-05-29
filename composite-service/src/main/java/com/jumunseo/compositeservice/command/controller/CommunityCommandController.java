package com.jumunseo.compositeservice.command.controller;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.jumunseo.compositeservice.command.dto.CommandDto;
import com.jumunseo.compositeservice.command.dto.external.BoardRequestDto;
import com.jumunseo.compositeservice.command.dto.external.CommentRequestDto;
import com.jumunseo.compositeservice.command.service.RedisService;
import com.jumunseo.compositeservice.global.aws.S3Uploader;
import com.jumunseo.compositeservice.global.exception.EventDeliveryError;
import com.jumunseo.compositeservice.global.exception.Result;
import com.jumunseo.compositeservice.query.controller.DebateQueryController;
import com.jumunseo.compositeservice.query.internal.DebateSummary;
import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;
import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequiredArgsConstructor
@RequestMapping("/command/community")
@Tag(name = "Community Command", description = "커뮤니티 서비스를 위한 커맨드 컨트롤러")
public class CommunityCommandController {
    private final RedisService redisService;
    private final S3Uploader s3Uploader;
    private final DebateQueryController debateQueryController;
    private final ObjectMapper objectMapper;
    // 여기서 사진은 무조건 올리기만 하자, 지우는거는 서버에서 지워줄거야

    // 글 생성 (일반)
    @PostMapping("/board/create")
    @Tag(name = "Community Command")
    @Operation(summary = "Posting Create", description = "게시글 생성 메소드")
    public ResponseEntity<Result<?>> createBoard(HttpServletRequest request, @RequestPart BoardRequestDto boardRequestDto,
                                                 @RequestPart(required = false) List<MultipartFile> files) {
        try {
            List<String> imageUrls = new ArrayList<>();
            for (MultipartFile file : files) {
                imageUrls.add(s3Uploader.upload("board", file));
            }
            boardRequestDto.setImageUrl(imageUrls);
            boardRequestDto.setUserId(request.getAttribute("email").toString());
            boardRequestDto.setCategory("NORMAL");
            // 일단 DTO 생성
            CommandDto data = new CommandDto();
            String requestStr = objectMapper.writeValueAsString(boardRequestDto);
            CommandDto sending_data = redisService.setMessage(request, data, requestStr, "Board_Create");

            // 전송
            redisService.send("community", sending_data);
            return ResponseEntity.ok(Result.successResult(null));
        }
        catch (Exception e) {
            throw new EventDeliveryError("이벤트를 Redis로 전달하는 과정에서 에러가 발생했습니다.");
        }
    }
    // 글 생성(마법사)
    @PostMapping("/board/create/magician")
    @Tag(name = "Community Command")
    @Operation(summary = "Posting Create", description = "게시글 생성 메소드 (마법사)")
    public ResponseEntity<Result<?>> createBoardMagician(HttpServletRequest request, @RequestBody BoardRequestDto boardRequestDto) {
        try {
            boardRequestDto.setUserId(request.getAttribute("email").toString());
            boardRequestDto.setCategory("MAGICIAN");
            boardRequestDto.setImageUrl(new ArrayList<>()); // 이미지는 없음
            // 일단 DTO 생성
            CommandDto data = new CommandDto();
            String requestStr = objectMapper.writeValueAsString(boardRequestDto);
            CommandDto sending_data = redisService.setMessage(request, data, requestStr, "Board_Create");

            // 전송
            redisService.send("community", sending_data);
            return ResponseEntity.ok(Result.successResult(null));
        }
        catch (Exception e) {
            throw new EventDeliveryError("이벤트를 Redis로 전달하는 과정에서 에러가 발생했습니다.");
        }
    }

    // 글 생성 (토론 요약)
    // 이건 자동 생성 (Cron Job)
    @Scheduled(cron = "0 5 12 * * ?")
    @Tag(name = "Community Command")
    @Operation(summary = "Posting Create", description = "게시글 생성 메소드(토론 요약), 매일 12시에 실행됩니다.(실행금지)")
    @PostMapping("/board/create/summary")
    public void createSummaryBoard() {
        try {
            Map<String,Object> jsonObject = (Map<String,Object>) debateQueryController.get_chat_summary_latest_method();
            // 일단 DTO 생성
            CommandDto data = new CommandDto();
            BoardRequestDto boardRequestDto = new BoardRequestDto();

            boardRequestDto.setCategory("SUMMARY");
            boardRequestDto.setUserId("ADMIN");
            boardRequestDto.setImageUrl(new ArrayList<>());
            boardRequestDto.setContent("");
            DebateSummary summary = objectMapper.convertValue(jsonObject.get("data"), DebateSummary.class);
            Map<String,Object> subject = objectMapper.convertValue(summary.getSubject(), Map.class);
            boardRequestDto.setDataId(summary.getId().toString());
            boardRequestDto.setTitle(subject.get("contents").toString());
            String requestStr = objectMapper.writeValueAsString(boardRequestDto);
            CommandDto sending_data = redisService.setMessage(data, requestStr, "Board_Create");

            // 전송
            redisService.send("community", sending_data);
        }
        catch (Exception e) {
//            throw new EventDeliveryError("이벤트를 Redis로 전달하는 과정에서 에러가 발생했습니다.");
            throw new EventDeliveryError(e.getMessage());
        }
    }


    // 글 삭제
    @DeleteMapping("/board/delete/{boardId}")
    @Tag(name = "Community Command")
    @Operation(summary = "Posting Delete", description = "게시글 삭제 메소드")
    public ResponseEntity<Result<?>> deleteBoard(HttpServletRequest request, @PathVariable Long boardId) {
        try {
            CommandDto data = new CommandDto();
            String requestStr = objectMapper.writeValueAsString(Map.of("boardId", boardId));
            CommandDto sending_data = redisService.setMessage(request, data, requestStr, "Board_Delete");

            // 전송
            redisService.send("community", sending_data);
            return ResponseEntity.ok(Result.successResult(null));
        } catch (Exception e) {
            throw new EventDeliveryError("이벤트를 Redis로 전달하는 과정에서 에러가 발생했습니다.");
        }
    }


    // 글 수정
    @PutMapping("/board/update/{boardId}")
    @Tag(name = "Community Command")
    @Operation(summary = "Posting Update", description = "게시글 수정 메소드")
    public ResponseEntity<Result<?>> updateBoard(HttpServletRequest request, @PathVariable Long boardId, @RequestPart Map<String,Object> update, @RequestPart(required = false) List<MultipartFile> files) {
        try {
            List<String> addImageUrls = new ArrayList<>();
            List<String> remainImageUrls = new ArrayList<>();
            System.out.println(files);
            if(files != null) {
                for (MultipartFile file : files) {
                    if (!file.isEmpty())
                        addImageUrls.add(s3Uploader.upload("board", file));
                }
            }
            Map<String,Object> newData = new HashMap<>();
            newData.put("boardId", boardId);
            if (update.get("title") != null) {
                newData.put("title", update.get("title"));
            }
            if (update.get("content") != null) {
                newData.put("content", update.get("content"));
            }
            if (update.get("imageUrls") != null){
                remainImageUrls.addAll((List<String>) update.get("imageUrls"));
            }

            // 이전 이미지를 유지하고 싶으면 이전 이미지 주소 넣어주기 (주소 형태로)
            // 삭제하고싶으면 삭제할 사진의 주소를 뺀 나머지만 넣어주기
            // 추가하고 싶은 사진은 그냥 사진 자체를 Multipart 로 넣어주기
            newData.put("addImageUrl", addImageUrls);
            newData.put("remainImageUrl", remainImageUrls);

            CommandDto data = new CommandDto();
            String requestStr = objectMapper.writeValueAsString(newData);
            CommandDto sending_data = redisService.setMessage(request, data, requestStr, "Board_Update");
            // 전송
            redisService.send("community",sending_data);

            return ResponseEntity.ok(Result.successResult(null));
        }
        catch (Exception e){
//            throw new EventDeliveryError("이벤트를 Redis로 전달하는 과정에서 에러가 발생했습니다.");
            throw new EventDeliveryError(e.getMessage());
        }
    }

    // 글 좋아요(토글)
    @PostMapping("/board/like/{boardId}")
    @Tag(name = "Community Command")
    @Operation(summary = "Posting Like", description = "게시글 좋아요 토글 메소드")
    public ResponseEntity<Result<?>> toggleLike(HttpServletRequest request, @PathVariable Long boardId) {
        try {
            CommandDto data = new CommandDto();
            String requestStr = objectMapper.writeValueAsString(Map.of("boardId", boardId));
            CommandDto sending_data = redisService.setMessage(request, data, requestStr, "Board_Like");

            // 전송
            redisService.send("community", sending_data);
            return ResponseEntity.ok(Result.successResult(null));
        } catch (Exception e) {
            throw new EventDeliveryError("이벤트를 Redis로 전달하는 과정에서 에러가 발생했습니다.");
        }
    }


    // 댓글 생성
    @PostMapping("/comment/create")
    @Tag(name = "Community Command")
    @Operation(summary = "Comment Create", description = "댓글 생성 메소드")
    public ResponseEntity<Result<?>> createComment(HttpServletRequest request, @RequestBody CommentRequestDto comment) {
        try {
            CommandDto data = new CommandDto();
            comment.setUserId(request.getAttribute("email").toString());
            if(comment.getHeadCommentId() == null) {
                comment.setHeadCommentId(-1L);
            }
            String requestStr = objectMapper.writeValueAsString(comment);
            System.out.println(requestStr);
            CommandDto sending_data = redisService.setMessage(request, data, requestStr, "Comment_Create");

            // 전송
            redisService.send("community", sending_data);
            return ResponseEntity.ok(Result.successResult(null));
        } catch (Exception e) {
            throw new EventDeliveryError("이벤트를 Redis로 전달하는 과정에서 에러가 발생했습니다.");
        }
    }

    // 댓글 삭제
    @DeleteMapping("/comment/delete/{commentId}")
    @Tag(name = "Community Command")
    @Operation(summary = "Comment Delete", description = "댓글 삭제 메소드")
    public ResponseEntity<Result<?>> deleteComment(HttpServletRequest request, @PathVariable Long commentId) {
        try {
            CommandDto data = new CommandDto();
            String requestStr = objectMapper.writeValueAsString(Map.of("commentId", commentId));
            CommandDto sending_data = redisService.setMessage(request, data, requestStr, "Comment_Delete");

            // 전송
            redisService.send("community", sending_data);
            return ResponseEntity.ok(Result.successResult(null));
        } catch (Exception e) {
            throw new EventDeliveryError("이벤트를 Redis로 전달하는 과정에서 에러가 발생했습니다.");
        }
    }
}
