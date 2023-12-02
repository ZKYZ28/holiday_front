import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/exceptions/api_exception.dart';
import 'package:holiday_mobile/data/models/activity/activity.dart';
import 'package:holiday_mobile/data/models/participant/participant.dart';
import 'package:holiday_mobile/data/repositories/activity_api_repository.dart';

part 'activity_event.dart';
part 'activity_state.dart';

class ActivityBloc extends Bloc<ActivityEvent, ActivityState> {
  final ActivityApiRepository activityApiRepository = ActivityApiRepository();

  ActivityBloc() : super(const ActivityState()) {

    on<GetActivity>((GetActivity event, Emitter<ActivityState> emit) async {
      try {
        emit(state.copyWith(status: ActivityStateStatus.loading));

        final activityId = event.activityId;
        final activity = await activityApiRepository.fetActivity(activityId);

        emit(state.copyWith(status: ActivityStateStatus.loaded, activity: activity));
      } on ApiException catch (e) {
        emit(state.copyWith(status: ActivityStateStatus.error, errorMessage : e.toString()));
      }
    });

    on<DeleteActivity>((DeleteActivity event, Emitter<ActivityState> emit) async {
      try {

        final activityId = event.activityId;
        await activityApiRepository.deleteActivity(activityId);

        emit(state.copyWith(status: ActivityStateStatus.deleted));
      } on ApiException catch (e) {
        emit(state.copyWith(status: ActivityStateStatus.error, errorMessage : e.toString()));
      }
    });

    on<DeleteParticipate>((DeleteParticipate event, Emitter<ActivityState> emit) async {
      try {
        final activityId = event.activityId;
        final participantId = event.participantId;

        await activityApiRepository.deleteParticipate(activityId, participantId);

      } on ApiException catch (e) {
        emit(state.copyWith(status: ActivityStateStatus.error,errorMessage : e.toString()));
      }
    });

    on<InitParticipates>((InitParticipates event, Emitter<ActivityState> emit) async {
      try {
        emit(state.copyWith(status: ActivityStateStatus.loading));

        final String activityId = event.activityId;

        final participantsInActivity = await activityApiRepository.getAllParticipantByActivity(activityId, true);
        final participantsNotYetInActivity = await activityApiRepository.getAllParticipantByActivity(activityId, false);

        emit(state.copyWith(status: ActivityStateStatus.loaded, participantsNotYetInActivity: participantsNotYetInActivity, participantsInActivity: participantsInActivity));

      } on ApiException catch (e) {
        emit(state.copyWith(status: ActivityStateStatus.error, errorMessage: e.toString()));
      }
    });

    on<CreateParticipates>((CreateParticipates event, Emitter<ActivityState> emit) async {
      try {
        final activityId = event.activityId;
        final participantsList = event.participants;

        for (int i = 0; i < participantsList.length; i++) {
          await activityApiRepository.createParticipate(activityId, participantsList[i].id!);
        }

        emit(state.copyWith(status: ActivityStateStatus.sent));
      } on ApiException catch (e) {
        emit(state.copyWith(status: ActivityStateStatus.error,errorMessage : e.toString()));
      }
    });
  }
}