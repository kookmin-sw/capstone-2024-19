// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversation_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ConversationModelImpl _$$ConversationModelImplFromJson(
        Map<String, dynamic> json) =>
    _$ConversationModelImpl(
      user_message: json['user_message'] as String,
      bot_response: json['bot_response'] as String,
    );

Map<String, dynamic> _$$ConversationModelImplToJson(
        _$ConversationModelImpl instance) =>
    <String, dynamic>{
      'user_message': instance.user_message,
      'bot_response': instance.bot_response,
    };
