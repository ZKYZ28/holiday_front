part of 'invitation_bloc.dart';

abstract class InvitationEvent extends Equatable{
  const InvitationEvent();

  @override
  List<Object> get props => [];
}

class CreateInvitations extends InvitationEvent {
  final List<Participant> participants;
  final String holidayId;

  const CreateInvitations({required this.participants, required this.holidayId});

  @override
  List<Object> get props => [participants, holidayId];
}


class GetAllInvitationsByParticipant extends InvitationEvent {}

class AcceptInvitation extends InvitationEvent {
  final Invitation invitation;

  const AcceptInvitation({required this.invitation});

  @override
  List<Object> get props => [invitation];
}

class RefuseInvitation extends InvitationEvent {
  final String invitationId;

  const RefuseInvitation({required this.invitationId});

  @override
  List<Object> get props => [invitationId];
}