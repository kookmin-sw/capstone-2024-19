import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WizardState{
  TextEditingController textEditingController = TextEditingController();

  final List<String> chats = [];
  final List<bool> myChat = [];
  
  final GlobalKey<AnimatedListState> statusKey = GlobalKey<AnimatedListState>();

  WebSocketChannel? socket;

  //유저 아이디
  String userId = 'sangrok';

  //선택 방 아이디 새로 만들기 시 그대로 -1
  String roomId = "-1";

  //선택 카테고리
  String cateogry = "";

  //육하원칙 값들
  String when = "";
  String where = "";
  String how = "";
  String who = "";
  String what = "";
  String why = "";
  String plusInfo = "";

  //마법사 봇 설정
  String explain = "냉정하게 대답해줘";
  String edit = "귀여운 말투로 대답해줘";
  String translate = "한국어로 대답해줘";
}