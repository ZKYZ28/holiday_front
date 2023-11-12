import 'package:holiday_mobile/data/models/weather_condition/weather_condition.dart';
import 'package:holiday_mobile/data/models/weather_hour/weather_hour.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather_day.g.dart';

@JsonSerializable()
class WeatherDay {
  final String date;
  final num maxTemp;
  final num minTemp;
  final num currentTemp;
  final num riskOfRain;
  final num riskOfSnow;
  final WeatherCondition condition;
  final List<WeatherHour> weatherByHour;

  WeatherDay({
    required this.date,
    required this.maxTemp,
    required this.minTemp,
    required this.currentTemp,
    required this.riskOfRain,
    required this.riskOfSnow,
    required this.condition,
    required this.weatherByHour,
  });

  factory WeatherDay.fromJson(Map<String, dynamic> json) => _$WeatherDayFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherDayToJson(this);
}