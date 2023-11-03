import 'package:json_annotation/json_annotation.dart';

part 'weather_condition.g.dart';

@JsonSerializable()
class WeatherCondition {
  final String description;
  final String iconPath;

  WeatherCondition({
    required this.description,
    required this.iconPath,
  });

  factory WeatherCondition.fromJson(Map<String, dynamic> json) => _$WeatherConditionFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherConditionToJson(this);
}