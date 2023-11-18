import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/exceptions/api_exception.dart';
import 'package:holiday_mobile/data/models/activity/activity.dart';
import 'package:holiday_mobile/data/repositories/activity_api_repository.dart';
import 'package:holiday_mobile/logic/blocs/holiday_bloc/holiday_bloc.dart';

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

        final activity= event.activity;
        await activityApiRepository.deleteActivity(activity);

        emit(state.copyWith(status: ActivityStateStatus.deleted));
      } on ApiException catch (e) {
        emit(state.copyWith(status: ActivityStateStatus.error, errorMessage : e.toString()));
      }
    });

  }
}