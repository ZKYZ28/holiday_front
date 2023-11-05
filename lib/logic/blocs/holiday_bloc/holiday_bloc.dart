import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/models/holiday/holiday.dart';
import 'package:holiday_mobile/data/repositories/holiday_api_repository.dart';

part 'holiday_event.dart';
part 'holiday_state.dart';

class HolidayBloc extends Bloc<HolidayEvent, HolidayState> {

  HolidayBloc() : super(HolidayInitial()) {
    final HolidayApiRepository holidayRepository = HolidayApiRepository();

    on<GetHolidayPublished>((event, emit) async {
      try {
        emit(HolidayLoading());

        final mList = await holidayRepository.fetchHolidayPublished();
        emit(HolidayLoaded(mList));
      } catch(e) {
        print("Erreur lors de communication avec l'API");
        emit(const HolidayError("Erreur lors de communication avec l'API"));
      }
    });
  }
}