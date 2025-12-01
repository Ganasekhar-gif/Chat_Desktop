import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/json_converters.dart';

part 'message.freezed.dart';
part 'message.g.dart';

@freezed
class Message with _$Message {
  const factory Message({
    required String id,
    required String roomId,
    required String senderId,
    required String text,
    @Default([]) List<String> unreadBy,
    @nullableDateTimeConverter DateTime? createdAt,

    // NEW FIELDS for attachments
    String? fileName,
    String? fileData, // base64 string
  }) = _Message;

  factory Message.fromJson(Map<String, dynamic> json) =>
      _$MessageFromJson(json);
}
