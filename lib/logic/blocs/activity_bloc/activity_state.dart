part of 'activity_bloc.dart';

enum ActivityStateStatus {initial, loading, loaded, error, deleted}

class ActivityState extends Equatable {
  final ActivityStateStatus status;
  final Activity? activity;
  final String? errorMessage;

  const ActivityState({
    this.status = ActivityStateStatus.initial,
    this.activity,
    this.errorMessage = "",
  });

  ActivityState copyWith({
    ActivityStateStatus? status,
    Activity? activity,
    String? errorMessage
  }) {
    return ActivityState(
        status : status ?? this.status,
        activity: activity ?? activity,
        errorMessage : errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object?> get props => [status, activity, errorMessage];

}