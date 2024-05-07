package com.jumunseo.debate.domain.opinion.entity;

import com.jumunseo.debate.domain.subject.entity.Subject;
import jakarta.persistence.*;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Entity
@Getter
@Setter
@NoArgsConstructor
@Table(name = "opinion")
public class Opinion {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @Lob
    private String content;

    private MessageType type;

    private MessageSide side;

    // Opinion과 Subject는 다대일 관계
    // 채팅방 주소는 Subject의 id이다.
    @ManyToOne(fetch = FetchType.LAZY)
    private Subject subject;

    // User와 매핑
    private String userEmail;

    @Builder
    public Opinion(String content, MessageType type, Subject subject, String userEmail, MessageSide side){
        this.content = content;
        this.type = type;
        this.subject = subject;
        this.userEmail = userEmail;
        this.side = side;
    }
}
