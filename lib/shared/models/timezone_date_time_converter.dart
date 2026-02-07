import 'package:json_annotation/json_annotation.dart';

class TimezoneDateTimeConverter implements JsonConverter<DateTime, String> {
  const TimezoneDateTimeConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json).toLocal();

  @override
  String toJson(DateTime object) => object.toIso8601String();
}
