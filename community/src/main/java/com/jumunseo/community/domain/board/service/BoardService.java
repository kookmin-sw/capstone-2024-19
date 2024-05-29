package com.jumunseo.community.domain.board.service;

import com.jumunseo.community.domain.board.dto.BoardListPhotoResponseDto;
import com.jumunseo.community.domain.board.dto.BoardListResponseDto;
import com.jumunseo.community.domain.board.dto.BoardRequestDto;
import com.jumunseo.community.domain.board.dto.BoardResponseDto;

import java.util.List;
import java.util.Map;

public interface BoardService {

    // 1. 게시글 등록
    void registerBoard(BoardRequestDto board);
    // 2. 게시글 수정

    void modifyBoard(Map<String,Object>update, String email);

    // 3. 게시글 삭제
    void removeBoard(Long boardId, String email);

    // 4. 게시글 조회
    BoardResponseDto getBoard(Long boardId, String userId);

    List<BoardListResponseDto> getBoardListByLatestAndCategory (Long index, String category);

    List<BoardListResponseDto> getBoardListByLatest(Long index);

    List<BoardListPhotoResponseDto> getBoardPhotoListByLatestAndCategory (Long index, String category);

    List<BoardListPhotoResponseDto> getBoardPhotoListByLatest(Long index);

    // 6. 게시글 좋아요 (토글)
    void Like(Long boardId, String userId);

    // 7. 게시글 좋아요 여부
    boolean isLiked(Long boardId, String email);
}
