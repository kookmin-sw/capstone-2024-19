import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jumunseo/config/theme/app_color.dart';
import '../chat.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  @override
  void initState(){
    super.initState();

    //웹소켓 연결
    context.read<WizardCubit>().sokectEventSetting(context);

    WidgetsBinding.instance
        .addPostFrameCallback((_) => context.read<WizardCubit>().pushFirstMessage());
  }

  @override
  void dispose(){
    context.read<WizardCubit>().socketDispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                ),
              ),
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
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: AnimatedList(
                  key: context.read<WizardCubit>().getStatusKey(),
                  itemBuilder : context.read<WizardCubit>().onSubmitAnimation,
                  reverse: true,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21.0, vertical: 36.0),
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
                      Expanded(
                        child: TextField(
                          controller: context.read<WizardCubit>().getChatMessage(),
                          decoration: const InputDecoration(
                            hintText: "Write additional message",
                            hintStyle: TextStyle(
                              fontSize: 13.0,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(0xff, 0xa1, 0xa1, 0xa1)
                            ),
                            border: InputBorder.none,
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                          ),
                          keyboardType: TextInputType.multiline,
                          minLines: 1,
                          maxLines: 7,
                          onSubmitted: (String text){
                            context.read<WizardCubit>().onButtonPress(context.read<WizardCubit>().getChatTextField());
                            context.read<WizardCubit>().clearChatTextField();
                          },
                        )),
                      GestureDetector(
                        child: ExtendedImage.asset(
                          'assets/images/send.png', 
                          width: 24.0, 
                          height: 24.0,
                        ),
                        onTap: () {
                          context.read<WizardCubit>().onButtonPress(context.read<WizardCubit>().getChatTextField());
                          context.read<WizardCubit>().clearChatTextField();
                        },
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