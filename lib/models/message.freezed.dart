// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'message.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Message _$MessageFromJson(Map<String, dynamic> json) {
  return _Message.fromJson(json);
}

/// @nodoc
mixin _$Message {
  String get id => throw _privateConstructorUsedError;
  String get roomId => throw _privateConstructorUsedError;
  String get senderId => throw _privateConstructorUsedError;
  String get text => throw _privateConstructorUsedError;
  List<String> get unreadBy => throw _privateConstructorUsedError;
  @nullableDateTimeConverter
  DateTime? get createdAt =>
      throw _privateConstructorUsedError; // NEW FIELDS for attachments
  String? get fileName => throw _privateConstructorUsedError;
  String? get fileData => throw _privateConstructorUsedError;

  /// Serializes this Message to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MessageCopyWith<Message> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessageCopyWith<$Res> {
  factory $MessageCopyWith(Message value, $Res Function(Message) then) =
      _$MessageCopyWithImpl<$Res, Message>;
  @useResult
  $Res call(
      {String id,
      String roomId,
      String senderId,
      String text,
      List<String> unreadBy,
      @nullableDateTimeConverter DateTime? createdAt,
      String? fileName,
      String? fileData});
}

/// @nodoc
class _$MessageCopyWithImpl<$Res, $Val extends Message>
    implements $MessageCopyWith<$Res> {
  _$MessageCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomId = null,
    Object? senderId = null,
    Object? text = null,
    Object? unreadBy = null,
    Object? createdAt = freezed,
    Object? fileName = freezed,
    Object? fileData = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      unreadBy: null == unreadBy
          ? _value.unreadBy
          : unreadBy // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
      fileData: freezed == fileData
          ? _value.fileData
          : fileData // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MessageImplCopyWith<$Res> implements $MessageCopyWith<$Res> {
  factory _$$MessageImplCopyWith(
          _$MessageImpl value, $Res Function(_$MessageImpl) then) =
      __$$MessageImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String roomId,
      String senderId,
      String text,
      List<String> unreadBy,
      @nullableDateTimeConverter DateTime? createdAt,
      String? fileName,
      String? fileData});
}

/// @nodoc
class __$$MessageImplCopyWithImpl<$Res>
    extends _$MessageCopyWithImpl<$Res, _$MessageImpl>
    implements _$$MessageImplCopyWith<$Res> {
  __$$MessageImplCopyWithImpl(
      _$MessageImpl _value, $Res Function(_$MessageImpl) _then)
      : super(_value, _then);

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? roomId = null,
    Object? senderId = null,
    Object? text = null,
    Object? unreadBy = null,
    Object? createdAt = freezed,
    Object? fileName = freezed,
    Object? fileData = freezed,
  }) {
    return _then(_$MessageImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      senderId: null == senderId
          ? _value.senderId
          : senderId // ignore: cast_nullable_to_non_nullable
              as String,
      text: null == text
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      unreadBy: null == unreadBy
          ? _value._unreadBy
          : unreadBy // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      fileName: freezed == fileName
          ? _value.fileName
          : fileName // ignore: cast_nullable_to_non_nullable
              as String?,
      fileData: freezed == fileData
          ? _value.fileData
          : fileData // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MessageImpl implements _Message {
  const _$MessageImpl(
      {required this.id,
      required this.roomId,
      required this.senderId,
      required this.text,
      final List<String> unreadBy = const [],
      @nullableDateTimeConverter this.createdAt,
      this.fileName,
      this.fileData})
      : _unreadBy = unreadBy;

  factory _$MessageImpl.fromJson(Map<String, dynamic> json) =>
      _$$MessageImplFromJson(json);

  @override
  final String id;
  @override
  final String roomId;
  @override
  final String senderId;
  @override
  final String text;
  final List<String> _unreadBy;
  @override
  @JsonKey()
  List<String> get unreadBy {
    if (_unreadBy is EqualUnmodifiableListView) return _unreadBy;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_unreadBy);
  }

  @override
  @nullableDateTimeConverter
  final DateTime? createdAt;
// NEW FIELDS for attachments
  @override
  final String? fileName;
  @override
  final String? fileData;

  @override
  String toString() {
    return 'Message(id: $id, roomId: $roomId, senderId: $senderId, text: $text, unreadBy: $unreadBy, createdAt: $createdAt, fileName: $fileName, fileData: $fileData)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MessageImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.senderId, senderId) ||
                other.senderId == senderId) &&
            (identical(other.text, text) || other.text == text) &&
            const DeepCollectionEquality().equals(other._unreadBy, _unreadBy) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.fileName, fileName) ||
                other.fileName == fileName) &&
            (identical(other.fileData, fileData) ||
                other.fileData == fileData));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      roomId,
      senderId,
      text,
      const DeepCollectionEquality().hash(_unreadBy),
      createdAt,
      fileName,
      fileData);

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      __$$MessageImplCopyWithImpl<_$MessageImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MessageImplToJson(
      this,
    );
  }
}

abstract class _Message implements Message {
  const factory _Message(
      {required final String id,
      required final String roomId,
      required final String senderId,
      required final String text,
      final List<String> unreadBy,
      @nullableDateTimeConverter final DateTime? createdAt,
      final String? fileName,
      final String? fileData}) = _$MessageImpl;

  factory _Message.fromJson(Map<String, dynamic> json) = _$MessageImpl.fromJson;

  @override
  String get id;
  @override
  String get roomId;
  @override
  String get senderId;
  @override
  String get text;
  @override
  List<String> get unreadBy;
  @override
  @nullableDateTimeConverter
  DateTime? get createdAt; // NEW FIELDS for attachments
  @override
  String? get fileName;
  @override
  String? get fileData;

  /// Create a copy of Message
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MessageImplCopyWith<_$MessageImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
