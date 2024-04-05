import 'package:freezed_annotation/freezed_annotation.dart';

import 'conversation_model.dart';

part 'room_model.g.dart';
part 'room_model.freezed.dart';

@freezed
class RoomModel with _$RoomModel{
  factory RoomModel(
      {required String id,
      required String start_time,
      required String user_id,
      required String room_id,
      required String added_prompt,
      required List<ConversationModel> conversation}) = _RoomModel;

  factory RoomModel.fromJson(Map<String, dynamic> json) =>
    _$RoomModelFromJson(json);
}