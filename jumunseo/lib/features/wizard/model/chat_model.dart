import 'package:freezed_annotation/freezed_annotation.dart';
import 'room_model.dart';

part 'chat_model.g.dart';
part 'chat_model.freezed.dart';

@freezed
class ChatModel with _$ChatModel{
  factory ChatModel(
      {required List<RoomModel> chats}) = _ChatModel;

  factory ChatModel.fromJson(Map<String, dynamic> json) =>
    _$ChatModelFromJson(json);
}