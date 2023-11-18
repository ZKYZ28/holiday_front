part of 'participate_bloc.dart';

abstract class ParticipateEvent extends Equatable{
  const ParticipateEvent();

  @override
  List<Object> get props => [];
}

class GetAllParticipatesByActivity extends ParticipateEvent {
  final String activityId;

  const GetAllParticipatesByActivity({required this.activityId});

  @override
  List<Object> get props => [activityId];
}

class CreateParticipates extends ParticipateEvent {
  final List<Participant> participants;
  final String activityId;

  const CreateParticipates({required this.participants, required this.activityId});

  @override
  List<Object> get props => [participants, activityId];
}

class DeleteParticipate extends ParticipateEvent {
  final Participate participate;

  const DeleteParticipate({required this.participate});

  @override
  List<Object> get props => [participate];
}
