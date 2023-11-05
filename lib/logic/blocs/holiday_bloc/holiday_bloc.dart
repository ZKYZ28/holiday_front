import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/models/holiday/holiday.dart';
import 'package:holiday_mobile/data/repositories/holiday_api_repository.dart';

part 'holiday_event.dart';
part 'holiday_state.dart';

class HolidayBloc extends Bloc<HolidayEvent, HolidayState> {
  final HolidayApiRepository holidayRepository = HolidayApiRepository();

  HolidayBloc() : super(HolidayInitial()) {


    on<GetHolidayByParticipant>((event, emit) async {
      try {
        emit(HolidayLoading());

        final participantId = event.participantId;
        final mList = await holidayRepository.fetchHolidayByParticipant(participantId);
        emit(HolidayLoaded(mList));
      } catch (e) {
        print("Erreur lors de communication avec l'API BY PARTICIPANT");
        emit(const HolidayError("Erreur lors de communication avec l'API"));
      }
    });

    on<GetHolidayPublished>((event, emit) async {
      try {
        emit(HolidayLoading());

        final mList = await holidayRepository.fetchHolidayPublished();
        emit(HolidayLoaded(mList));
      } catch (e) {
        print("Erreur lors de la communication avec l'API PUBLISHED");
        emit(const HolidayError("Erreur lors de la communication avec l'API"));
      }
    });
  }
}