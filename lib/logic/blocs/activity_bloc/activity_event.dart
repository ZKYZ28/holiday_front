part of 'activity_bloc.dart';

abstract class ActivityEvent extends Equatable{
  const ActivityEvent();

  @override
  List<Object> get props => [];
}


class GetActivity extends ActivityEvent {
  final String activityId;

  const GetActivity({required this.activityId});

  @override
  List<Object> get props => [activityId];
}

class DeleteActivity extends ActivityEvent {
  final String activityId;

  const DeleteActivity({required this.activityId});

  @override
  List<Object> get props => [activityId];
}

class DeleteParticipate extends ActivityEvent {
  final String activityId;
  final String participantId;

  const DeleteParticipate({required this.activityId, required this.participantId});

  @override
  List<Object> get props => [activityId, participantId];
}

class GetParticipantsByActivity extends ActivityEvent {
  final String activityId;
  final bool isParticipated;

  const GetParticipantsByActivity({required this.activityId, required this.isParticipated});

  @override
  List<Object> get props => [activityId];
}


class CreateParticipates extends ActivityEvent {
  final String activityId;
  final List<Participant> participants;

  const CreateParticipates({required this.activityId, required this.participants});

  @override
  List<Object> get props => [activityId, participants];
}

class InitParticipates extends ActivityEvent {
  final String activityId;

  const InitParticipates({required this.activityId});

  @override
  List<Object> get props => [activityId];
}