import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/exceptions/api_exception.dart';
import 'package:holiday_mobile/data/models/participate/participate.dart';
import '../../../data/repositories/participate_api_repository.dart';
import 'package:holiday_mobile/data/models/participant/participant.dart';

part 'participate_event.dart';
part 'participate_state.dart';


class ParticipateBloc extends Bloc<ParticipateEvent, ParticipateState> {
  final ParticipateApiRepository participateApiRepository = ParticipateApiRepository();

  ParticipateBloc() : super(const ParticipateState()) {

    on<GetAllParticipatesByActivity>((GetAllParticipatesByActivity event, Emitter<ParticipateState> emit) async {
      try {
        emit(state.copyWith(status: ParticipateStateStatus.loading));

        final String activityId = event.activityId;
        final participants = await participateApiRepository.getAllParticipatesByActivity(activityId);

        emit(state.copyWith(status: ParticipateStateStatus.loaded, participatesList: participants));
      } on ApiException catch (e) {
        emit(state.copyWith(status: ParticipateStateStatus.error, errorMessage: e.toString()));
      }
    });

    on<CreateParticipates>((CreateParticipates event, Emitter<ParticipateState> emit) async {
      try {
        final List<Participant> participants = event.participants;
        final activityId = event.activityId;

        await participateApiRepository.createParticipates(participants, activityId);

        emit(state.copyWith(status: ParticipateStateStatus.sent));
      } on ApiException catch (e) {
        emit(state.copyWith(status: ParticipateStateStatus.error,errorMessage : e.toString()));
      }
    });

    on<DeleteParticipate>((DeleteParticipate event, Emitter<ParticipateState> emit) async {
      try {
        final participateId = event.participateId;

        await participateApiRepository.deleteParticipate(participateId);

        emit(state.copyWith(status: ParticipateStateStatus.loading));
        emit(state.copyWith(status: ParticipateStateStatus.loaded));
      } on ApiException catch (e) {
        emit(state.copyWith(status: ParticipateStateStatus.error,errorMessage : e.toString()));
      }
    });

  }
}