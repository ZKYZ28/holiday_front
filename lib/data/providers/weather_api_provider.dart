import 'package:dio/dio.dart';
import 'package:holiday_mobile/data/exceptions/api_exception.dart';
import 'package:holiday_mobile/data/models/weather/weather.dart';
import 'package:holiday_mobile/data/providers/dio_instance.dart';

class WeatherApiProvider{
  final Dio _dio = DioService().dio;


  Future<Weather> fetchWeatherByHoliday(String holidayId) async {
    try {
      Response response = await _dio.get('v1/Weather/$holidayId');

      // conversion list
      Weather weather = Weather.fromJson(response.data);

      return weather;

    } on DioException catch (e){
      throw ApiException(e.response?.data, e);

    } catch (e, stacktrace) {
      throw ApiException("Une erreur s'est produite lors de la récupération des vacances publiées", stacktrace);
    }
  }
}