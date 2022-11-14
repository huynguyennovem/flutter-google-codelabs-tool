import 'package:json_annotation/json_annotation.dart';

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String json) => DateTime.parse(json).toLocal(); // response time is UTC: 2022-11-12T16:32:35.035Z

  @override
  String toJson(DateTime object) => object.toIso8601String();
}