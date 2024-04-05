import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:jumunseo/config/theme/app_color.dart';
import 'package:jumunseo/features/wizard/chat/view/wizard_setting_select.dart';

class SettingView extends StatefulWidget {
  const SettingView({super.key});

  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  @override
  Widget build(BuildContext context) {
    List<String> imageNames = ['assets/images/explain.png', 'assets/images/edit.png', 'assets/images/translate.png'];
    List<String> setNames = ['Explain', 'Write & edit', 'Translate'];

    List<List<String>> answerList = [
      ['냉정하게 대답해줘', '그냥 내 편을 들어줘'],
      ['귀여운 말투로 대답해줘', '진지한 말투로 대답해줘', '냥냥체로 대답해줘'],
      ['한국어로 대답해줘', '영어로 대답해줘'],
    ];

    //웹소켓 연결
    // context.read<WizardCubit>().sokectEventSetting(context);

    return Scaffold(
      backgroundColor: Colors.blue.shade50,
      appBar: AppBar(
        title: Row(
          children: [
            ExtendedImage.asset('assets/images/mage.png', width: 24.0, height: 36.0,),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
              "주문서 봇",
              style: TextStyle(
                color: ColorStyles.mainColor,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),),
            ),]
        ),
        shape: const Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
      ),
      body: Container(
        //배경 색상 그라데이션 표시
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        //채팅이 올라오는 화면과 채팅을 치는 텍스트 필드 전송 버튼 묶음 컬럼
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: List.generate(imageNames.length, (index) {
                  return WizardSet(imageNames[index], setNames[index], answerList[index]);
                }),
              ),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(start: 20.0, end: 20.0, bottom: 36.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                  //채팅을 치는 텍스트 필드, 전송 버튼 구분 로우
                  child: Row(
                    children: [
                      const Expanded(
                        child: Text(
                          '마법사봇의 성격을 설정해주세요!',
                          style: TextStyle(
                            color: ColorStyles.mainColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 13.0,
                          ),
                        ),
                      ),
                      ExtendedImage.asset(
                        'assets/images/send.png', 
                        width: 24.0, 
                        height: 24.0,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}