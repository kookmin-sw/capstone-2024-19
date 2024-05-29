package com.jumunseo.debate.domain.subject.repository;

import com.jumunseo.debate.domain.subject.dto.SubjectCollectDto;
import com.jumunseo.debate.domain.subject.dto.SubjectDto;
import com.jumunseo.debate.domain.subject.entity.Subject;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;

public interface SubjectJPARepository extends JpaRepository<Subject, Long> {

    // 연관정보 X (Opinion) 이 객체에 들어가지 않는다. -> N+1 고려 X
    @Query("SELECT new com.jumunseo.debate.domain.subject.dto.SubjectDto(s.contents,s.startTime,s.endTime,s.id) FROM Subject s WHERE :now BETWEEN s.startTime AND s.endTime")
    List<SubjectDto> findByStartTimeAndEndTime(LocalDateTime now);
    @Query("SELECT new com.jumunseo.debate.domain.subject.dto.SubjectCollectDto(s.contents) FROM Subject s ORDER BY s.startTime DESC LIMIT 30")
    List<SubjectCollectDto> findTop30ByStartTimeOrderByStartTimeDesc(LocalDateTime startTime);
    Optional<Subject> findSubjectDtoById (Long id);
    Optional<Subject> findTop1ByEndTimeBeforeOrderByStartTimeDesc(LocalDateTime endTime);

    // Test
    Optional<Subject> findTop1ByOrderByIdDesc();
}
