import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/json_converters.dart';

part 'room.freezed.dart';
part 'room.g.dart';

@freezed
class Room with _$Room {
  const factory Room({
    required String id,
    required String name,
    required List<String> members,
    @Default('') String iconUrl,
    @nullableDateTimeConverter DateTime? updatedAt,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}
 
