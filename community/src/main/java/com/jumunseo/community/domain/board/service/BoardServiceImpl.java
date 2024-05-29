package com.jumunseo.community.domain.board.service;

import com.jumunseo.community.domain.board.dto.*;
import com.jumunseo.community.domain.board.entity.Board;
import com.jumunseo.community.domain.board.entity.Image;
import com.jumunseo.community.domain.board.entity.LikeBoard;
import com.jumunseo.community.domain.board.exceptions.NoBoardException;
import com.jumunseo.community.domain.board.repository.BoardRepository;
import com.jumunseo.community.domain.board.repository.ImageRepository;
import com.jumunseo.community.domain.board.repository.LikeRepository;
import com.jumunseo.community.global.util.S3Uploader;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
@RequiredArgsConstructor
public class BoardServiceImpl implements BoardService {

    private final BoardMapper mapper;
    private final BoardRepository boardRepository;
    private final LikeRepository likeRepository;
    private final ImageRepository imageRepository;
    private final S3Uploader s3Uploader;

    @Override
    @Transactional
    public void registerBoard(BoardRequestDto boardDTO) {

        Board board = mapper.requestToEntity(boardDTO);
        if(boardDTO.getCategory().equals("SUMMARY") || boardDTO.getCategory().equals("MAGICIAN")){
            board.setDataId(boardDTO.getDataId());
        }
        else {
            board.setDataId("-1");
        }

        boardRepository.save(board);
        System.out.println(board.getCategory());
        System.out.println(board.getDataId());
        List<String> imageUrls = boardDTO.getImageUrl();
        for(String imageUrl : imageUrls) {
            imageRepository.save(Image.builder().path(imageUrl).board(board).build());
        }
    }

    @Override
    @Transactional
    public void modifyBoard(Map<String,Object>update, String email) {
        Board board = boardRepository.findById(Long.valueOf(update.get("boardId").toString())).orElseThrow((
        ) -> new NoBoardException("해당 게시글이 존재하지 않습니다."));

        if(!board.getUserId().equals(email)) {
            throw new IllegalArgumentException("해당 게시글을 수정할 권한이 없습니다.");
        }

        if(update.get("title") != null)
            board.setTitle((String) update.get("title"));
        if(update.get("content") != null)
            board.setContent((String) update.get("content"));
        // 받은 URL 에 남아있다면 유지, 사라졌다면 삭제.
        if (update.get("remainImageUrl") != null) {
            // 기존 이미지 삭제
            List<String> remainImageUrl = (List<String>) update.get("remainImageUrl");
            for(Image image : board.getImageUrl()) {
                if (!remainImageUrl.contains(image.getPath())) { // 남아있는 이미지가 아니라면 삭제
                    s3Uploader.delete(image.getPath());
                    imageRepository.delete(image);
                }
            }
        }
        // 이미지 추가
        if (update.get("addImageUrl") != null) {
            List<String> imageUrls = (List<String>) update.get("addImageUrl");
            for(String imageUrl : imageUrls) {
                imageRepository.save(Image.builder().path(imageUrl).board(board).build());
            }
        }
        // 업데이트 시간 설정
        board.setUpdatedAt(LocalDateTime.now());
    }

    @Override
    @Transactional
    public void removeBoard(Long boardId, String email) {
        Board board = boardRepository.findById(boardId).orElseThrow((
        ) -> new NoBoardException("해당 게시글이 존재하지 않습니다."));

        if(!board.getUserId().equals(email)) {
            throw new IllegalArgumentException("해당 게시글을 삭제할 권한이 없습니다.");
        }
        for(Image image : board.getImageUrl()) {
            s3Uploader.delete(image.getPath());
        }
        imageRepository.deleteAll(board.getImageUrl()); // 게시글에 달린 이미지 삭제
        boardRepository.delete(board); // 게시글 삭제
    }

    @Override
    @Transactional
    public BoardResponseDto getBoard(Long boardId, String userId) {
        Board board = boardRepository.findById(boardId).orElseThrow((
        ) -> new NoBoardException("해당 게시글이 존재하지 않습니다."));
        board.addViewCount();
        BoardResponseDto boardResponseDto = mapper.entityToBoardResponse(board);
        if(userId.equals("UNSIGNED")) {
            boardResponseDto.setMy_Like(false);
        }
        else {
            boardResponseDto.setMy_Like(likeRepository.findByBoardAndUserId(board, userId).isPresent());
        }
        return boardResponseDto; // 게시글 조회
    }

    @Override
    public List<BoardListResponseDto> getBoardListByLatestAndCategory(Long index, String category) {
        List<Board> boards;
        if(index == -1L){
            boards = boardRepository.findAllByLatestAndCategory(category);
        }
        else {
            boards = boardRepository.findAllByCategoryAndIndex(index, category);
        }
        List<BoardListResponseDto> boardResponseDtos = new ArrayList<>();
        for(Board board : boards) {
            boardResponseDtos.add(mapper.entityToBoardListResponse(board));
        }
        return boardResponseDtos;
    }


    @Override
    public List<BoardListResponseDto> getBoardListByLatest(Long index) {
        List<Board> boards;
        if(index == -1L)
            boards = boardRepository.findAllByLatest();
        else {
            boards = boardRepository.findAllByIndex(index);
        }
        List<BoardListResponseDto> boardResponseDtos = new ArrayList<>();
        for(Board board : boards) {
            boardResponseDtos.add(mapper.entityToBoardListResponse(board));
        }
        return boardResponseDtos;
    }

    @Override
    public List<BoardListPhotoResponseDto> getBoardPhotoListByLatestAndCategory(Long index, String category) {
        List<Board> boards;
        if(index == -1L){
            boards = boardRepository.findAllByLatestAndCategory(category);
        }
        else {
            boards = boardRepository.findAllByCategoryAndIndex(index, category);
        }
        List<BoardListPhotoResponseDto> boardResponseDtos = new ArrayList<>();
        for(Board board : boards) {
            boardResponseDtos.add(mapper.entityToBoardListPhotoResponse(board));
        }
        return boardResponseDtos;
    }


    @Override
    public List<BoardListPhotoResponseDto> getBoardPhotoListByLatest(Long index) {
        List<Board> boards;
        if(index == -1L)
            boards = boardRepository.findAllByLatest();
        else {
            boards = boardRepository.findAllByIndex(index);
        }
        List<BoardListPhotoResponseDto> boardResponseDtos = new ArrayList<>();
        for(Board board : boards) {
            boardResponseDtos.add(mapper.entityToBoardListPhotoResponse(board));
        }
        return boardResponseDtos;
    }




    @Override
    @Transactional
    public void Like(Long boardId, String userId) {
        Board board = boardRepository.findById(boardId).orElseThrow((
        ) -> new NoBoardException("해당 게시글이 존재하지 않습니다."));

        if(likeRepository.findByBoardAndUserId(board, userId).isPresent()) {
            LikeBoard like = likeRepository.findByBoardAndUserId(board, userId).get();
            likeRepository.delete(like);
        } else {
            LikeBoard like = LikeBoard.builder()
                    .board(board)
                    .userId(userId)
                    .build();
            likeRepository.save(like);
        }
    }
}
