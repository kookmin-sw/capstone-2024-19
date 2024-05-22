// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_edit_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserEditResponseModelImpl _$$UserEditResponseModelImplFromJson(
        Map<String, dynamic> json) =>
    _$UserEditResponseModelImpl(
      code: json['code'] as String,
      message: json['message'] as String,
      data: json['data'] == null
          ? null
          : EditInfoModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$UserEditResponseModelImplToJson(
        _$UserEditResponseModelImpl instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'data': instance.data,
    };
