import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jumunseo/features/wizard/chat/view/chat_view.dart';
import 'package:jumunseo/features/wizard/chat/view/fwoh_view.dart';
import 'package:jumunseo/features/wizard/model/room_model.dart';
import 'package:logger/logger.dart';
import 'package:web_socket_channel/io.dart';
import '../state/wizard_state.dart';
import '../view/my_chat_message.dart';
import '../view/other_chat_message.dart';

class WizardCubit extends Cubit<WizardState> {
  WizardCubit() : super(WizardState());

  void onButtonPress(String txt){
    if(txt != ""){
      Logger().d(txt);

      state.chats.insert(0, txt);
      state.myChat.insert(0, true);
      state.statusKey.currentState?.insertItem(0);
      state.socket?.sink.add(txt);
    }
  }

  void pushPrompt(String txt) {
    Logger().d(txt);
    state.socket?.sink.add(txt);
  }

  String getChatTextField() {
    return state.textEditingController.text;
  }

  void clearChatTextField() {
    state.textEditingController.clear();
  }

  String getUserId() {
    return state.userId;
  }

  void chatInsert(String data) {
    state.chats.insert(0, data);
    state.myChat.insert(0, false);
    state.statusKey.currentState?.insertItem(0);
  }

  void setPrompt(String prompt) {
    List<String> prompts = prompt.split(',');

    state.explain = prompts[0];
    state.edit = prompts[1];
    state.translate = prompts[2];
  }

  String parsingCategory(RoomModel room) {
    if(room.conversation.isNotEmpty) {
      if(room.conversation[0].user_message.contains('카테고리')){
        Logger().d(room.conversation[0].user_message);
        String category = room.conversation[0].user_message.split("\n")[0].split(":")[1].replaceAll(",", "");
        return category;
      }
    }

    return "";
  }

  void sokectEventSetting(BuildContext context){
    state.myChat.clear();
    state.chats.clear();

    state.socket = IOWebSocketChannel.connect(Uri.parse('ws://10.0.2.2:8000/ws/${state.userId}'));

    Logger().d('서버 연결 시작');

    // 메세지 감지
    state.socket?.stream.listen((data) {
      Logger().d('Received message: $data');
      chatInsert(data);
    });

    pushPrompt("${state.explain},${state.edit},${state.translate}/${state.roomId}");
  }

  void pushFirstMessage() {
    if(state.roomId == "-1"){
      onButtonPress("카테고리:${state.cateogry},\n언제?: ${state.when},\n왜?: ${state.why},\n어디서?: ${state.where},\n무엇을?: ${state.what},\n어떻게?: ${state.how},\n누가?: ${state.who}\n,추가 정보: ${state.plusInfo}");
    }
  }

  void setExplain(String newExplain) {
    state.explain = newExplain;
  }

  String getExplain() {
    return state.explain;
  }

  void setEdit(String newEdit) {
    state.edit = newEdit;
  }
  
  String getEdit() {
    return state.edit;
  }

  void setTranslate(String newTranslate) {
    state.translate = newTranslate;
  }

  String getTranslate() {
    return state.translate;
  }

  void setWhy(String newWhy){
    state.why = newWhy;
  }

  void setWhat(String newWhat){
    state.what = newWhat;
  }

  void setWho(String newWho){
    state.who = newWho;
  }

  void setHow(String newHow){
    state.how = newHow;
  }

  void setWhen(String newWhen){
    state.when = newWhen;
  }

  void setWhere(String newWhere){
    state.where = newWhere;
  }

  void setPlusInfo(String newPlusInfo){
    state.plusInfo = newPlusInfo;
  }

  void socketDispose(){
    state.socket?.sink.close();
  }

  Widget onSubmitAnimation(BuildContext context, int index, Animation<double> animation){
    if(state.myChat[index]) {
      return MyChatMsg("나", state.chats[index], animation);
    } else {
      return OtherChatMsg("상담사", state.chats[index], animation);
    }
  }

  TextEditingController getChatMessage() {
    return state.textEditingController;
  }

  GlobalKey<AnimatedListState> getStatusKey() {
    return state.statusKey;
  }

  void setCateogry(String newCategory) {
    state.cateogry = newCategory;
  }

  String getCategory() {
    return state.cateogry;
  }

  void setRoom(String newId) {
    state.roomId = newId;
  }

  void toFwoh(BuildContext context) {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (context)=> const FwohView())
    );
  }

  void toChat(BuildContext context, TextEditingController? textEdit) {
    if(textEdit != null){
      if(textEdit.text.trim() != ""){
        setPlusInfo(textEdit.text);
      }
    }

    Navigator.push(
        context, 
        MaterialPageRoute(builder: (context)=> const ChatView())
      );
  }

  void toWizardSet(BuildContext context) {
    context.push("/wizard/chat_set");
  }

  void toCategory(BuildContext context) {
    context.push("/wizard/category");
  }

  void toWhen(BuildContext context) {
    context.push("/wizard/when");
  }

  void toWhere(BuildContext context, TextEditingController textEdit) {
    if(textEdit.text.trim() != "") {
      setWhy(textEdit.text);

      context.push("/wizard/where");
    }
  }

  void toWho(BuildContext context, TextEditingController textEdit) {
    if(textEdit.text.trim() != "") {
      setHow(textEdit.text);

      context.push("/wizard/who");
    }
  }

  void toWhat(BuildContext context, TextEditingController textEdit) {
    if(textEdit.text.trim() != ""){
      setWhere(textEdit.text);

      context.push("/wizard/what");
    }
  }

  void toHow(BuildContext context, TextEditingController textEdit) {
    if(textEdit.text.trim() != ""){
      setWhat(textEdit.text);

      context.push("/wizard/how");
    }
  }

  void toWhy(BuildContext context, TextEditingController textEdit) {
    if(textEdit.text.trim() != ""){
      setWhen(textEdit.text);

      context.push("/wizard/why");
    }
  }

  void toPlusInfo(BuildContext context, TextEditingController textEdit) {
    if(textEdit.text.trim() != ""){
      setWho(textEdit.text);

      context.push("/wizard/plus_info");
    }
  }
}