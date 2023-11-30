import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/exceptions/api_exception.dart';
import 'package:holiday_mobile/data/models/holiday/holiday.dart';
import 'package:holiday_mobile/data/models/participant/participant.dart';
import 'package:holiday_mobile/data/repositories/authentification_api_repository.dart';
import 'package:holiday_mobile/data/repositories/participant_api_repository.dart';

part 'participant_event.dart';
part 'participant_state.dart';

class ParticipantBloc extends Bloc<ParticipantEvent, ParticipantState> {
  final ParticipantApiRepository participantApiRepository = ParticipantApiRepository();
  late AuthRepository _repository;

    ParticipantBloc({ required AuthRepository repository}) : super(const ParticipantState()) {
    _repository = repository;

    on<LeaveHoliday>((LeaveHoliday event, Emitter<ParticipantState> emit) async {
      try {
        final holiday = event.holiday;

        await participantApiRepository.leaveHoliday(holiday.id!);

        emit(state.copyWith(status: ParticipantStateStatus.left));
      } on ApiException catch (e) {
        emit(state.copyWith(status: ParticipantStateStatus.error, errorMessage: e.toString()));
      }
    });

    on<GetAllParticipantNotYetInHoliday>((GetAllParticipantNotYetInHoliday event, Emitter<ParticipantState> emit) async {
      try {
        emit(state.copyWith(status: ParticipantStateStatus.loading));

        final String holidayId = event.holidayId;
        final participants = await participantApiRepository.getAllParticipantNotYetInHoliday(holidayId, false);

        emit(state.copyWith(status: ParticipantStateStatus.loaded, participantsList: participants));
      } on ApiException catch (e) {
        emit(state.copyWith(status: ParticipantStateStatus.error, errorMessage: e.toString()));
      }
    });

    on<GetAllParticipantNotYetInActivity>((GetAllParticipantNotYetInActivity event, Emitter<ParticipantState> emit) async {
      try {
        emit(state.copyWith(status: ParticipantStateStatus.loading));

        final String activityId = event.activityId;
        final participants = await participantApiRepository.getAllParticipantNotYetInActivity(activityId);

        emit(state.copyWith(status: ParticipantStateStatus.loaded, participantsList: participants));
      } on ApiException catch (e) {
        emit(state.copyWith(status: ParticipantStateStatus.error, errorMessage: e.toString()));
      }
    });

  }
}