// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_info_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserInfoResponseModel _$UserInfoResponseModelFromJson(
    Map<String, dynamic> json) {
  return _UserInfoResponseModel.fromJson(json);
}

/// @nodoc
mixin _$UserInfoResponseModel {
  String get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  InfoModel? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserInfoResponseModelCopyWith<UserInfoResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInfoResponseModelCopyWith<$Res> {
  factory $UserInfoResponseModelCopyWith(UserInfoResponseModel value,
          $Res Function(UserInfoResponseModel) then) =
      _$UserInfoResponseModelCopyWithImpl<$Res, UserInfoResponseModel>;
  @useResult
  $Res call({String code, String message, InfoModel? data});

  $InfoModelCopyWith<$Res>? get data;
}

/// @nodoc
class _$UserInfoResponseModelCopyWithImpl<$Res,
        $Val extends UserInfoResponseModel>
    implements $UserInfoResponseModelCopyWith<$Res> {
  _$UserInfoResponseModelCopyWithImpl(this._value, this._then);

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
              as InfoModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $InfoModelCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $InfoModelCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$UserInfoResponseModelImplCopyWith<$Res>
    implements $UserInfoResponseModelCopyWith<$Res> {
  factory _$$UserInfoResponseModelImplCopyWith(
          _$UserInfoResponseModelImpl value,
          $Res Function(_$UserInfoResponseModelImpl) then) =
      __$$UserInfoResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, String message, InfoModel? data});

  @override
  $InfoModelCopyWith<$Res>? get data;
}

/// @nodoc
class __$$UserInfoResponseModelImplCopyWithImpl<$Res>
    extends _$UserInfoResponseModelCopyWithImpl<$Res,
        _$UserInfoResponseModelImpl>
    implements _$$UserInfoResponseModelImplCopyWith<$Res> {
  __$$UserInfoResponseModelImplCopyWithImpl(_$UserInfoResponseModelImpl _value,
      $Res Function(_$UserInfoResponseModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = freezed,
  }) {
    return _then(_$UserInfoResponseModelImpl(
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
              as InfoModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserInfoResponseModelImpl implements _UserInfoResponseModel {
  _$UserInfoResponseModelImpl(
      {required this.code, required this.message, required this.data});

  factory _$UserInfoResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserInfoResponseModelImplFromJson(json);

  @override
  final String code;
  @override
  final String message;
  @override
  final InfoModel? data;

  @override
  String toString() {
    return 'UserInfoResponseModel(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserInfoResponseModelImpl &&
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
  _$$UserInfoResponseModelImplCopyWith<_$UserInfoResponseModelImpl>
      get copyWith => __$$UserInfoResponseModelImplCopyWithImpl<
          _$UserInfoResponseModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserInfoResponseModelImplToJson(
      this,
    );
  }
}

abstract class _UserInfoResponseModel implements UserInfoResponseModel {
  factory _UserInfoResponseModel(
      {required final String code,
      required final String message,
      required final InfoModel? data}) = _$UserInfoResponseModelImpl;

  factory _UserInfoResponseModel.fromJson(Map<String, dynamic> json) =
      _$UserInfoResponseModelImpl.fromJson;

  @override
  String get code;
  @override
  String get message;
  @override
  InfoModel? get data;
  @override
  @JsonKey(ignore: true)
  _$$UserInfoResponseModelImplCopyWith<_$UserInfoResponseModelImpl>
      get copyWith => throw _privateConstructorUsedError;
}
