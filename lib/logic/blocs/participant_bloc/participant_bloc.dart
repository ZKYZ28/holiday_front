import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/exceptions/api_exception.dart';
import 'package:holiday_mobile/data/models/holiday/holiday.dart';
import 'package:holiday_mobile/data/models/participant/participant.dart';
import 'package:holiday_mobile/data/repositories/participant_api_repository.dart';

part 'participant_event.dart';
part 'participant_state.dart';

class ParticipantBloc extends Bloc<ParticipantEvent, ParticipantState> {
  final ParticipantApiRepository participantApiRepository = ParticipantApiRepository();

  ParticipantBloc() : super(ParticipantInitial()) {

    on<LeaveHoliday>((event, emit) async {
      try {
        final String participantId = event.participantId;
        final holiday = event.holiday;
        await participantApiRepository.leaveHoliday(participantId, holiday);

      } on ApiException catch (e) {
        emit(ParticipantError(e.toString()));
      }
    });

    on<GetAllParticipantNotYetInHoliday>((event, emit) async {
      try {
        emit(ParticipantLoading());

        final String holidayId = event.holidayId;
        final participants = await participantApiRepository.getAllParticipantNotYetInHoliday(holidayId);

        emit(ParticipantLoaded(participants));
      } on ApiException catch (e) {
        emit(ParticipantError(e.toString()));
      }
    });

  }
}