import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jumunseo/features/auth/model/info_model.dart';

part 'user_info_response_model.g.dart';
part 'user_info_response_model.freezed.dart';

@freezed
class UserInfoResponseModel with _$UserInfoResponseModel{
  factory UserInfoResponseModel(
      {required String code,
      required String message,
      required InfoModel? data}) = _UserInfoResponseModel;

  factory UserInfoResponseModel.fromJson(Map<String, dynamic> json) =>
    _$UserInfoResponseModelFromJson(json);
}