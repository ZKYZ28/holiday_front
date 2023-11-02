import 'package:holiday_mobile/data/models/weather_day.dart';

class Weather {
  final WeatherDay currentDay;
  final List<WeatherDay> weatherDays;

  Weather({
    required this.currentDay,
    required this.weatherDays,
  });
}