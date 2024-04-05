// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomModelImpl _$$RoomModelImplFromJson(Map<String, dynamic> json) =>
    _$RoomModelImpl(
      id: json['_id'] as String,
      start_time: json['start_time'] as String,
      user_id: json['user_id'] as String,
      room_id: json['room_id'] as String,
      added_prompt: json['added_prompt'] as String,
      conversation: (json['conversation'] as List<dynamic>)
          .map((e) => ConversationModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$RoomModelImplToJson(_$RoomModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'start_time': instance.start_time,
      'user_id': instance.user_id,
      'room_id': instance.room_id,
      'added_prompt': instance.added_prompt,
      'conversation': instance.conversation,
    };
