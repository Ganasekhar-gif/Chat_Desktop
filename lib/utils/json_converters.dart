import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:json_annotation/json_annotation.dart';

class NullableDateTimeConverter
    extends JsonConverter<DateTime?, Object?> {
  const NullableDateTimeConverter();

  @override
  DateTime? fromJson(Object? value) {
    if (value == null) return null;

    if (value is Timestamp) {
      return value.toDate();
    }

    if (value is DateTime) {
      return value;
    }

    if (value is int) {
      return DateTime.fromMillisecondsSinceEpoch(value);
    }

    if (value is double) {
      return DateTime.fromMillisecondsSinceEpoch(value.toInt());
    }

    if (value is String) {
      return DateTime.tryParse(value);
    }

    return null;
  }

  @override
  Object? toJson(DateTime? value) {
    return value?.toIso8601String();
  }
}

const NullableDateTimeConverter nullableDateTimeConverter =
    NullableDateTimeConverter();

