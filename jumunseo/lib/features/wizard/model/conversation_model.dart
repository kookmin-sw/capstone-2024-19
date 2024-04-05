import 'package:freezed_annotation/freezed_annotation.dart';

part 'conversation_model.g.dart';
part 'conversation_model.freezed.dart';

@freezed
class ConversationModel with _$ConversationModel{
  factory ConversationModel(
      {required String user_message,
      required String bot_response}) = _ConversationModel;

  factory ConversationModel.fromJson(Map<String, dynamic> json) =>
    _$ConversationModelFromJson(json);
}