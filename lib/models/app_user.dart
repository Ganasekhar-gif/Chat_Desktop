import 'package:freezed_annotation/freezed_annotation.dart';

import '../utils/json_converters.dart';

part 'app_user.freezed.dart';
part 'app_user.g.dart';

@freezed
class AppUser with _$AppUser {
  const factory AppUser({
    required String id,
    required String email,
    required String name,
    @Default('') String photoUrl,
    @Default(false) bool isOnline,
    @nullableDateTimeConverter DateTime? lastSeen,
  }) = _AppUser;

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
}
