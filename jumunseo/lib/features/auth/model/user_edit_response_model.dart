import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:jumunseo/features/auth/model/edit_info_model.dart';

part 'user_edit_response_model.g.dart';
part 'user_edit_response_model.freezed.dart';

@freezed
class UserEditResponseModel with _$UserEditResponseModel{
  factory UserEditResponseModel(
      {required String code,
      required String message,
      required EditInfoModel? data}) = _UserEditResponseModel;

  factory UserEditResponseModel.fromJson(Map<String, dynamic> json) =>
    _$UserEditResponseModelFromJson(json);
}