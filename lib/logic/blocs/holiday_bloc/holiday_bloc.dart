import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/exceptions/api_exception.dart';
import 'package:holiday_mobile/data/models/holiday/holiday.dart';
import 'package:holiday_mobile/data/repositories/authentification_api_repository.dart';
import 'package:holiday_mobile/data/repositories/holiday_api_repository.dart';

part 'holiday_event.dart';
part 'holiday_state.dart';

class HolidayBloc extends Bloc<HolidayEvent, HolidayState> {
  final HolidayApiRepository holidayRepository = HolidayApiRepository();
  late AuthRepository _repository;

  HolidayBloc({ required AuthRepository repository}) : super(const HolidayState()) {
    _repository = repository;

    on<GetHolidayByParticipant>((GetHolidayByParticipant event, Emitter<HolidayState> emit) async {
      try {
        emit(state.copyWith(status: HolidayStateStatus.loading));

        final participantId = _repository.userConnected.id;
        final holidaysByParticipant = await holidayRepository.fetchHolidayByParticipant(participantId);

        emit(state.copyWith(status: HolidayStateStatus.loaded, holidaysList: holidaysByParticipant));
      } on ApiException catch (e) {
        emit(state.copyWith(status: HolidayStateStatus.error, errorMessage : e.toString()));
      }
    });

    on<GetHolidayPublished>((GetHolidayPublished event, Emitter<HolidayState> emit) async {
      try {
        emit(state.copyWith(status: HolidayStateStatus.loading));

        final holidaysPublished = await holidayRepository.fetchHolidayPublished();

        emit(state.copyWith(status: HolidayStateStatus.loaded, holidaysList: holidaysPublished));
      } on ApiException catch (e) {
        emit(state.copyWith(status: HolidayStateStatus.error, errorMessage : e.toString()));
      }
    });

    on<GetHoliday>((GetHoliday event, Emitter<HolidayState> emit) async {
      try {
        emit(state.copyWith(status: HolidayStateStatus.loading));

        final holidayId = event.holidayId;
        final holiday = await holidayRepository.fetchHoliday(holidayId);

        emit(state.copyWith(status: HolidayStateStatus.loaded, holidayItem: holiday));
      } on ApiException catch (e) {
        emit(state.copyWith(status: HolidayStateStatus.error, errorMessage : e.toString()));
      }
    });

    on<PublishHoliday>((PublishHoliday event, Emitter<HolidayState> emit) async {
      try {
        final holiday = event.holiday;

        await holidayRepository.publishHoliday(holiday);

        emit(state.copyWith(status: HolidayStateStatus.published));
      } on ApiException catch (e) {
        emit(state.copyWith(status: HolidayStateStatus.error, errorMessage : e.toString()));
      }
    });

    on<DeleteHoliday>((DeleteHoliday event, Emitter<HolidayState> emit) async {
      try {
        final holiday = event.holiday;
        await holidayRepository.deleteHoliday(holiday);

      } on ApiException catch (e) {
        emit(state.copyWith(status: HolidayStateStatus.error, errorMessage : e.toString()));
      }
    });

    on<WaitingActivityAction>((WaitingActivityAction event, Emitter<HolidayState> emit) async {
      emit(state.copyWith(status: HolidayStateStatus.waitingActivityAction));
    });

  }
}