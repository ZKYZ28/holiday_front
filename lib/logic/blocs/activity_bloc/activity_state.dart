part of 'activity_bloc.dart';

enum ActivityStateStatus {initial, loading, loaded, error, deleted, sent}

class ActivityState extends Equatable {
  final ActivityStateStatus status;
  final Activity? activity;
  final String? errorMessage;
  final List<Participant>? participantsInActivity;
  final List<Participant>? participantsNotYetInActivity;

  const ActivityState({
    this.status = ActivityStateStatus.initial,
    this.activity,
    this.errorMessage = "",
    this.participantsInActivity,
    this.participantsNotYetInActivity,
  });

  ActivityState copyWith({
    ActivityStateStatus? status,
    Activity? activity,
    String? errorMessage,
    List<Participant>? participantsInActivity,
    List<Participant>? participantsNotYetInActivity
  }) {
    return ActivityState(
        status : status ?? this.status,
        activity: activity ?? activity,
        errorMessage : errorMessage ?? this.errorMessage,
        participantsInActivity: participantsInActivity ?? participantsInActivity,
        participantsNotYetInActivity: participantsNotYetInActivity ?? participantsNotYetInActivity
    );
  }

  @override
  List<Object?> get props => [status, activity, participantsInActivity, participantsNotYetInActivity,  errorMessage];

}