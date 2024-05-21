// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reissue_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ReIssueModel _$ReIssueModelFromJson(Map<String, dynamic> json) {
  return _ReIssueModel.fromJson(json);
}

/// @nodoc
mixin _$ReIssueModel {
  String get code => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  ReIssueTokenModel get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ReIssueModelCopyWith<ReIssueModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReIssueModelCopyWith<$Res> {
  factory $ReIssueModelCopyWith(
          ReIssueModel value, $Res Function(ReIssueModel) then) =
      _$ReIssueModelCopyWithImpl<$Res, ReIssueModel>;
  @useResult
  $Res call({String code, String message, ReIssueTokenModel data});

  $ReIssueTokenModelCopyWith<$Res> get data;
}

/// @nodoc
class _$ReIssueModelCopyWithImpl<$Res, $Val extends ReIssueModel>
    implements $ReIssueModelCopyWith<$Res> {
  _$ReIssueModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = null,
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
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ReIssueTokenModel,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ReIssueTokenModelCopyWith<$Res> get data {
    return $ReIssueTokenModelCopyWith<$Res>(_value.data, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$ReIssueModelImplCopyWith<$Res>
    implements $ReIssueModelCopyWith<$Res> {
  factory _$$ReIssueModelImplCopyWith(
          _$ReIssueModelImpl value, $Res Function(_$ReIssueModelImpl) then) =
      __$$ReIssueModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String code, String message, ReIssueTokenModel data});

  @override
  $ReIssueTokenModelCopyWith<$Res> get data;
}

/// @nodoc
class __$$ReIssueModelImplCopyWithImpl<$Res>
    extends _$ReIssueModelCopyWithImpl<$Res, _$ReIssueModelImpl>
    implements _$$ReIssueModelImplCopyWith<$Res> {
  __$$ReIssueModelImplCopyWithImpl(
      _$ReIssueModelImpl _value, $Res Function(_$ReIssueModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = null,
    Object? message = null,
    Object? data = null,
  }) {
    return _then(_$ReIssueModelImpl(
      code: null == code
          ? _value.code
          : code // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      data: null == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as ReIssueTokenModel,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReIssueModelImpl implements _ReIssueModel {
  _$ReIssueModelImpl(
      {required this.code, required this.message, required this.data});

  factory _$ReIssueModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReIssueModelImplFromJson(json);

  @override
  final String code;
  @override
  final String message;
  @override
  final ReIssueTokenModel data;

  @override
  String toString() {
    return 'ReIssueModel(code: $code, message: $message, data: $data)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReIssueModelImpl &&
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
  _$$ReIssueModelImplCopyWith<_$ReIssueModelImpl> get copyWith =>
      __$$ReIssueModelImplCopyWithImpl<_$ReIssueModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReIssueModelImplToJson(
      this,
    );
  }
}

abstract class _ReIssueModel implements ReIssueModel {
  factory _ReIssueModel(
      {required final String code,
      required final String message,
      required final ReIssueTokenModel data}) = _$ReIssueModelImpl;

  factory _ReIssueModel.fromJson(Map<String, dynamic> json) =
      _$ReIssueModelImpl.fromJson;

  @override
  String get code;
  @override
  String get message;
  @override
  ReIssueTokenModel get data;
  @override
  @JsonKey(ignore: true)
  _$$ReIssueModelImplCopyWith<_$ReIssueModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
