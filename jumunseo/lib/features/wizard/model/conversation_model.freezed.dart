// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'conversation_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ConversationModel _$ConversationModelFromJson(Map<String, dynamic> json) {
  return _ConversationModel.fromJson(json);
}

/// @nodoc
mixin _$ConversationModel {
  String get user_message => throw _privateConstructorUsedError;
  String get bot_response => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ConversationModelCopyWith<ConversationModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConversationModelCopyWith<$Res> {
  factory $ConversationModelCopyWith(
          ConversationModel value, $Res Function(ConversationModel) then) =
      _$ConversationModelCopyWithImpl<$Res, ConversationModel>;
  @useResult
  $Res call({String user_message, String bot_response});
}

/// @nodoc
class _$ConversationModelCopyWithImpl<$Res, $Val extends ConversationModel>
    implements $ConversationModelCopyWith<$Res> {
  _$ConversationModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user_message = null,
    Object? bot_response = null,
  }) {
    return _then(_value.copyWith(
      user_message: null == user_message
          ? _value.user_message
          : user_message // ignore: cast_nullable_to_non_nullable
              as String,
      bot_response: null == bot_response
          ? _value.bot_response
          : bot_response // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ConversationModelImplCopyWith<$Res>
    implements $ConversationModelCopyWith<$Res> {
  factory _$$ConversationModelImplCopyWith(_$ConversationModelImpl value,
          $Res Function(_$ConversationModelImpl) then) =
      __$$ConversationModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String user_message, String bot_response});
}

/// @nodoc
class __$$ConversationModelImplCopyWithImpl<$Res>
    extends _$ConversationModelCopyWithImpl<$Res, _$ConversationModelImpl>
    implements _$$ConversationModelImplCopyWith<$Res> {
  __$$ConversationModelImplCopyWithImpl(_$ConversationModelImpl _value,
      $Res Function(_$ConversationModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? user_message = null,
    Object? bot_response = null,
  }) {
    return _then(_$ConversationModelImpl(
      user_message: null == user_message
          ? _value.user_message
          : user_message // ignore: cast_nullable_to_non_nullable
              as String,
      bot_response: null == bot_response
          ? _value.bot_response
          : bot_response // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ConversationModelImpl implements _ConversationModel {
  _$ConversationModelImpl(
      {required this.user_message, required this.bot_response});

  factory _$ConversationModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ConversationModelImplFromJson(json);

  @override
  final String user_message;
  @override
  final String bot_response;

  @override
  String toString() {
    return 'ConversationModel(user_message: $user_message, bot_response: $bot_response)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ConversationModelImpl &&
            (identical(other.user_message, user_message) ||
                other.user_message == user_message) &&
            (identical(other.bot_response, bot_response) ||
                other.bot_response == bot_response));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, user_message, bot_response);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ConversationModelImplCopyWith<_$ConversationModelImpl> get copyWith =>
      __$$ConversationModelImplCopyWithImpl<_$ConversationModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ConversationModelImplToJson(
      this,
    );
  }
}

abstract class _ConversationModel implements ConversationModel {
  factory _ConversationModel(
      {required final String user_message,
      required final String bot_response}) = _$ConversationModelImpl;

  factory _ConversationModel.fromJson(Map<String, dynamic> json) =
      _$ConversationModelImpl.fromJson;

  @override
  String get user_message;
  @override
  String get bot_response;
  @override
  @JsonKey(ignore: true)
  _$$ConversationModelImplCopyWith<_$ConversationModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
