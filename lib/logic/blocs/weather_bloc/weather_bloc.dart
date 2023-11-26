import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/exceptions/api_exception.dart';
import 'package:holiday_mobile/data/models/weather/weather.dart';
import 'package:holiday_mobile/data/repositories/weather_api_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherApiRepository weatherRepository = WeatherApiRepository();

  WeatherBloc() : super(const WeatherState()) {
    on<GetWeather>((event, emit) async {
      try {
        emit(state.copyWith(status: WeatherStateStatus.loading));

        final holidayId = event.holidayId;
        final weather = await weatherRepository.fetWeather(holidayId);

        emit(state.copyWith(status: WeatherStateStatus.loaded, weather: weather));
      } on ApiException catch (e) {
        emit(state.copyWith(status: WeatherStateStatus.error, errorMessage : e.toString()));
      }
    });
  }
}