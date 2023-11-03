import 'package:json_annotation/json_annotation.dart';

part 'weather_hour.g.dart';

@JsonSerializable()
class WeatherHour {
  final String dateAndTime;
  final int temp;
  final String pathImage;

  WeatherHour({
    required this.dateAndTime,
    required this.temp,
    required this.pathImage,
  });

  factory WeatherHour.fromJson(Map<String, dynamic> json) => _$WeatherHourFromJson(json);
  Map<String, dynamic> toJson() => _$WeatherHourToJson(this);
}