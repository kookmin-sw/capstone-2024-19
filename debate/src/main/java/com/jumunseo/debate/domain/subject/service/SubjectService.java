package com.jumunseo.debate.domain.subject.service;

import com.jumunseo.debate.domain.subject.dto.SubjectDto;

import java.util.List;

public interface SubjectService {
    // 매일 자정에 주제를 새로고침한다.
    // 주제를 새로고침하면, 기존 정보에 해당하는 토론 내용들이 Json 형태로 OpenApi 요약 서버로 이동.
    void summarySubject();

    // 현재 사용가능한 주제를 가져온다.
    List<SubjectDto> getLiveSubject();

    // 주제를 추가한다.
    void addSubject();

    // 해당 주제가 유효한가? (채팅방이 열려있는가?)
    boolean isValidSubject(Long subjectId);
}
