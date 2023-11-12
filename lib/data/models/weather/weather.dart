import 'package:holiday_mobile/data/models/weather_day/weather_day.dart';
import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather {
  final WeatherDay? currentDay;
  final List<WeatherDay> weatherDays;

  Weather({
    this.currentDay,
    required this.weatherDays,
  });

  factory Weather.fromJson(Map<String, dynamic> json) => _$WeatherFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherToJson(this);
}