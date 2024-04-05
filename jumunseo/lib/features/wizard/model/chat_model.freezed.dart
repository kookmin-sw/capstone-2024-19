// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chat_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ChatModel _$ChatModelFromJson(Map<String, dynamic> json) {
  return _ChatModel.fromJson(json);
}

/// @nodoc
mixin _$ChatModel {
  List<RoomModel> get chats => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatModelCopyWith<ChatModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatModelCopyWith<$Res> {
  factory $ChatModelCopyWith(
          ChatModel value, $Res Function(ChatModel) then) =
      _$ChatModelCopyWithImpl<$Res, ChatModel>;
  @useResult
  $Res call({List<RoomModel> chats});
}

/// @nodoc
class _$ChatModelCopyWithImpl<$Res, $Val extends ChatModel>
    implements $ChatModelCopyWith<$Res> {
  _$ChatModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chats = null,
  }) {
    return _then(_value.copyWith(
      chats: null == chats
          ? _value.chats
          : chats // ignore: cast_nullable_to_non_nullable
              as List<RoomModel>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ChatModelImplCopyWith<$Res>
    implements $ChatModelCopyWith<$Res> {
  factory _$$ChatModelImplCopyWith(
          _$ChatModelImpl value, $Res Function(_$ChatModelImpl) then) =
      __$$ChatModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<RoomModel> chats});
}

/// @nodoc
class __$$ChatModelImplCopyWithImpl<$Res>
    extends _$ChatModelCopyWithImpl<$Res, _$ChatModelImpl>
    implements _$$ChatModelImplCopyWith<$Res> {
  __$$ChatModelImplCopyWithImpl(
      _$ChatModelImpl _value, $Res Function(_$ChatModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? chats = null,
  }) {
    return _then(_$ChatModelImpl(
      chats: null == chats
          ? _value._chats
          : chats // ignore: cast_nullable_to_non_nullable
              as List<RoomModel>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ChatModelImpl implements _ChatModel {
  _$ChatModelImpl({required final List<RoomModel> chats}) : _chats = chats;

  factory _$ChatModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ChatModelImplFromJson(json);

  final List<RoomModel> _chats;
  @override
  List<RoomModel> get chats {
    if (_chats is EqualUnmodifiableListView) return _chats;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_chats);
  }

  @override
  String toString() {
    return 'ChatModel(chats: $chats)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatModelImpl &&
            const DeepCollectionEquality().equals(other._chats, _chats));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_chats));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatModelImplCopyWith<_$ChatModelImpl> get copyWith =>
      __$$ChatModelImplCopyWithImpl<_$ChatModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ChatModelImplToJson(
      this,
    );
  }
}

abstract class _ChatModel implements ChatModel {
  factory _ChatModel({required final List<RoomModel> chats}) =
      _$ChatModelImpl;

  factory _ChatModel.fromJson(Map<String, dynamic> json) =
      _$ChatModelImpl.fromJson;

  @override
  List<RoomModel> get chats;
  @override
  @JsonKey(ignore: true)
  _$$ChatModelImplCopyWith<_$ChatModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
