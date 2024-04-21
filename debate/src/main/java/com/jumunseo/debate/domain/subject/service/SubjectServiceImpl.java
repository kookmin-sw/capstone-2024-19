package com.jumunseo.debate.domain.subject.service;

import com.jumunseo.debate.domain.opinion.dto.OpinionSimpleDto;
import com.jumunseo.debate.domain.opinion.entity.MessageSide;
import com.jumunseo.debate.domain.opinion.repository.OpinionJPARepository;
import com.jumunseo.debate.domain.opinion.service.OpinionServiceImpl;
import com.jumunseo.debate.domain.subject.dto.SubjectCollectDto;
import com.jumunseo.debate.domain.subject.dto.SubjectDto;
import com.jumunseo.debate.domain.subject.entity.Subject;
import com.jumunseo.debate.domain.subject.entity.SubjectSummary;
import com.jumunseo.debate.domain.subject.exception.NotExistSubjectException;
import com.jumunseo.debate.domain.subject.repository.SubjectJPARepository;
import com.jumunseo.debate.domain.subject.repository.SubjectSummartJPARepository;
import com.jumunseo.debate.global.dto.Mapper;
import com.jumunseo.debate.global.open_ai.OpenAIService;
import com.jumunseo.debate.global.stomp.RedisChannelService;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;


@Service
@RequiredArgsConstructor
public class SubjectServiceImpl implements SubjectService{

    private final SubjectJPARepository subjectRepository;
    private final OpenAIService openAIService;
    private final RedisChannelService redisChannelService;
    private final SubjectSummartJPARepository subjectSummartJPARepository;
    private final OpinionJPARepository opinionRepository;
    private final Mapper mapper;

    // 매일 정오에 주제를 새로고침한다.
    @Scheduled(cron = "0 0 12 * * *")
    public void summarySubject(){
        // 시간이 지난 주제에 대해 요약을 하고, 해당 주제를 레디스 토픽에서 삭제한다.

        // 1. 시간이 막 지난 주제를 가져온다.
        Subject subject = subjectRepository.findTopByEndTimeBefore(LocalDateTime.now());
        subjectRepository.delete(subject);

        // 2. 해당 주제를 레디스 토픽에서 삭제한다.
        redisChannelService.unregisterChannel(subject.getContents());

        // 3. 해당 주제에 대한 요약을 한다.
        // 3.1 1번의견(Left) 요약.
        List<OpinionSimpleDto> leftOpinion = getOpinionSideSummary(subject, MessageSide.LEFT);
        String leftSide = summaryOpinions(leftOpinion, subject.getContents());
        // 3.2 2번의견(Right) 요약.
        List<OpinionSimpleDto> rightOpinion = getOpinionSideSummary(subject, MessageSide.RIGHT);
        String rightSide = summaryOpinions(rightOpinion, subject.getContents());

        SubjectSummary subjectSummary = SubjectSummary.builder()
                .subject(subject)
                .leftOpinions(leftSide)
                .rightOpinions(rightSide)
                .build();

        subjectSummartJPARepository.save(subjectSummary);

        // TODO: 4. 요약된 의견들을 Community에 요청.
        // 일단은 출력만.
        System.out.println(subjectSummary);
    }

    // 주제를 추가한다.
    // OpenAI 기반
    @Scheduled(cron = "0 0 12 * * *")
    public void addSubject(){
        // OpenAI에 보낼 요청문 빌드.
        List<String> req = new ArrayList<>();
        req.add("사람들이 법적으로 곤란해 할만한 주제를 만들어주세요," +
                " 해당 주제는 찬성, 반대로 의견이 나뉘어서 사람들이 논쟁을 벌일 수 있을만한 것이여야하고" +
                " 당신은 \"주제\" 를 의문형으로 ~해야 하는가? 의 형식으로 작성해주세요 이외의 다른 정보는 필요하지 않습니다." +
                " 인사말이나 네 알겠습니다 이런 말은 필요하지 않습니다." +
                " 또한 \"\"주제\": \" 이런 형식 없이 오로지 주제만 입력해 주세요"+
                " 아래 입력되는 문장들인 이미 사용된 주제들 입니다. 이 주제와 중복되지 않고 참신한 주제로 만들어주세요");

        List<SubjectCollectDto> history = subjectRepository.findTop100ByStartTime(LocalDateTime.now());
        StringBuilder tempword = new StringBuilder();
        for (SubjectCollectDto subject : history) {
            tempword.append(subject.getContents());
        }
        req.add(tempword + "이 주제들은 이미 사용된 주제들 입니다. 이 주제들과 중복되지 않고 참신한 주제로 만들어주세요");

        // OpenAI에 요청을 보내서 주제를 받아온다.
        String sub = openAIService.sendRequest(req, "너는 오늘 토론의 주제를 만들어주는 인공지능이야");

        // 해당 주제를 레디스 토픽에 추가, 이제 해당 주제를 구독할 수 있다.
        redisChannelService.registerChannel(sub);

        // 해당 주제를 DB에 추가.
        Subject subject = Subject.builder()
                .contents(sub)
                .build();

        subjectRepository.save(subject);
    }


    // 채팅 신청이 오면 유효한 주제인지 확인.
    @Override
    public boolean isValidSubject(Long subjectId) {
        // 주제의 시간 유효성 확인
        SubjectDto subjectDto = subjectRepository.findSubjectDtoById(subjectId).orElseThrow(
                () -> new NotExistSubjectException("주제가 존재하지 않습니다."));

        return subjectDto.getStartTime().isBefore(LocalDateTime.now()) && subjectDto.getEndTime().isAfter(LocalDateTime.now());
    }


    // 현재 사용가능한 주제를 가져온다.
    @Override
    public List<SubjectDto> getLiveSubject(){
        return subjectRepository.findByStartTimeAndEndTime(LocalDateTime.now());
    }

    // 의견을 요약한다.
    private String summaryOpinions(List<OpinionSimpleDto> opinions, String sub){
        List<String> req = new ArrayList<>();
        req.add("이 주제에 대한 의견을 요약해주세요, 이 의견들에 대한 주제는 " + sub + "입니다." +
                "또한 이 의견과 관계 없는 대화 내용은 필터링 해주시고, 주된 의견들에 대해 약 5개 정도 요약해주세요.");

        StringBuilder tempword = new StringBuilder();
        for (OpinionSimpleDto opinion : opinions) {
            tempword.append(opinion.getContent());
        }
        req.add(tempword.toString());

        return openAIService.sendRequest(req, ".md 형태로 정리해 주세요");
    }

    public List<OpinionSimpleDto> getOpinionSideSummary(Subject subject, MessageSide side){
        return opinionRepository.findBySubjectAndSide(subject, side).stream().map(mapper::toSimpleOption).toList();
    }
}
