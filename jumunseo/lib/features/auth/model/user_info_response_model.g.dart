// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserInfoResponseModelImpl _$$UserInfoResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UserInfoResponseModelImpl(
      code: json['code'] as String,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : InfoModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserInfoResponseModelImplToJson(
        _$UserInfoResponseModelImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
