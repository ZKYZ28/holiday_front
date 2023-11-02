import 'package:holiday_mobile/data/models/weather_condition.dart';
import 'package:holiday_mobile/data/models/weather_hour.dart';


class WeatherDay {
  final String date;
  final double maxTemp;
  final double minTemp;
  final double currentTemp;
  final double riskOfRain;
  final double riskOfSnow;
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
}