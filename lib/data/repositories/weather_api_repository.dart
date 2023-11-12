import 'package:holiday_mobile/data/models/weather/weather.dart';
import 'package:holiday_mobile/data/providers/weather_api_provider.dart';

class WeatherApiRepository{
  final _weatherProvider = WeatherApiProvider();

  Future<Weather> fetWeather(String holidayId) {
    return _weatherProvider.fetchWeatherByHoliday(holidayId);
  }
}