// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$MessageImpl _$$MessageImplFromJson(Map<String, dynamic> json) =>
    _$MessageImpl(
      id: json['id'] as String,
      roomId: json['roomId'] as String,
      senderId: json['senderId'] as String,
      text: json['text'] as String,
      unreadBy: (json['unreadBy'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: nullableDateTimeConverter.fromJson(json['createdAt']),
      fileName: json['fileName'] as String?,
      fileData: json['fileData'] as String?,
    );

Map<String, dynamic> _$$MessageImplToJson(_$MessageImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'roomId': instance.roomId,
      'senderId': instance.senderId,
      'text': instance.text,
      'unreadBy': instance.unreadBy,
      'createdAt': nullableDateTimeConverter.toJson(instance.createdAt),
      'fileName': instance.fileName,
      'fileData': instance.fileData,
    };
