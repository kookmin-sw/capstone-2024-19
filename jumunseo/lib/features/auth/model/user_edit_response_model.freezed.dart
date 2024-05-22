// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_edit_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserEditResponseModel _$UserEditResponseModelFromJson(
    Map<String, dynamic> json) {
  return _UserEditResponseModel.fromJson(json);
}

/// @nodoc
mixin _$UserEditResponseModel {
  String get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  EditInfoModel? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserEditResponseModelCopyWith<UserEditResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserEditResponseModelCopyWith<$Res> {
  factory $UserEditResponseModelCopyWith(UserEditResponseModel value,
          $Res Function(UserEditResponseModel) then) =
      _$UserEditResponseModelCopyWithImpl<$Res, UserEditResponseModel>;
  @useResult
  $Res call({String code, String message, EditInfoModel? data});

  $EditInfoModelCopyWith<$Res>? get data;
}

/// @nodoc
class _$UserEditResponseModelCopyWithImpl<$Res,
        $Val extends UserEditResponseModel>
    implements $UserEditResponseModelCopyWith<$Res> {
  _$UserEditResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as EditInfoModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EditInfoModelCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $EditInfoModelCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserEditResponseModelImplCopyWith<$Res>
    implements $UserEditResponseModelCopyWith<$Res> {
  factory _$$UserEditResponseModelImplCopyWith(
          _$UserEditResponseModelImpl value,
          $Res Function(_$UserEditResponseModelImpl) then) =
      __$$UserEditResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, String message, EditInfoModel? data});

  @override
  $EditInfoModelCopyWith<$Res>? get data;
}

/// @nodoc
class __$$UserEditResponseModelImplCopyWithImpl<$Res>
    extends _$UserEditResponseModelCopyWithImpl<$Res,
        _$UserEditResponseModelImpl>
    implements _$$UserEditResponseModelImplCopyWith<$Res> {
  __$$UserEditResponseModelImplCopyWithImpl(_$UserEditResponseModelImpl _value,
      $Res Function(_$UserEditResponseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$UserEditResponseModelImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as EditInfoModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserEditResponseModelImpl implements _UserEditResponseModel {
  _$UserEditResponseModelImpl(
      {required this.code, required this.message, required this.data});

  factory _$UserEditResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserEditResponseModelImplFromJson(json);

  @override
  final String code;
  @override
  final String message;
  @override
  final EditInfoModel? data;

  @override
  String toString() {
    return 'UserEditResponseModel(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserEditResponseModelImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, code, message, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserEditResponseModelImplCopyWith<_$UserEditResponseModelImpl>
      get copyWith => __$$UserEditResponseModelImplCopyWithImpl<
          _$UserEditResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserEditResponseModelImplToJson(
      this,
    );
  }
}

abstract class _UserEditResponseModel implements UserEditResponseModel {
  factory _UserEditResponseModel(
      {required final String code,
      required final String message,
      required final EditInfoModel? data}) = _$UserEditResponseModelImpl;

  factory _UserEditResponseModel.fromJson(Map<String, dynamic> json) =
      _$UserEditResponseModelImpl.fromJson;

  @override
  String get code;
  @override
  String get message;
  @override
  EditInfoModel? get data;
  @override
  @JsonKey(ignore: true)
  _$$UserEditResponseModelImplCopyWith<_$UserEditResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
