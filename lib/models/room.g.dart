// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomImpl _$$RoomImplFromJson(Map<String, dynamic> json) => _$RoomImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      members:
          (json['members'] as List<dynamic>).map((e) => e as String).toList(),
      iconUrl: json['iconUrl'] as String? ?? '',
      updatedAt: nullableDateTimeConverter.fromJson(json['updatedAt']),
    );

Map<String, dynamic> _$$RoomImplToJson(_$RoomImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'members': instance.members,
      'iconUrl': instance.iconUrl,
      'updatedAt': nullableDateTimeConverter.toJson(instance.updatedAt),
    };
