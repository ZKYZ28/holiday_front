import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/exceptions/api_exception.dart';
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
        final holidaysByParticipant = await holidayRepository.fetchHolidayByParticipant(participantId);

        emit(HolidayLoaded.list(holidaysByParticipant));
      } on ApiException catch (e) {
        emit(HolidayError(e.toString()));
      }
    });

    on<GetHolidayPublished>((event, emit) async {
      try {
        emit(HolidayLoading());

        final holidaysPublished = await holidayRepository.fetchHolidayPublished();

        emit(HolidayLoaded.list(holidaysPublished));
      } on ApiException catch (e) {
        emit(HolidayError(e.toString()));
      }
    });

    on<GetHoliday>((event, emit) async {
      try {
        emit(HolidayLoading());

        final holidayId = event.holidayId;
        final holiday = await holidayRepository.fetchHoliday(holidayId);

        emit(HolidayLoaded.item(holiday));
      } on ApiException catch (e) {
        emit(HolidayError(e.toString()));
      }
    });

    on<PublishHoliday>((event, emit) async {
      try {
        final holiday = event.holiday;
        await holidayRepository.publishHoliday(holiday);

      } on ApiException catch (e) {
        emit(HolidayError(e.toString()));
      }
    });

    on<DeleteHoliday>((event, emit) async {
      try {
        final holiday = event.holiday;
        await holidayRepository.deleteHoliday(holiday);

      } on ApiException catch (e) {
        emit(HolidayError(e.toString()));
      }
    });

  }
}