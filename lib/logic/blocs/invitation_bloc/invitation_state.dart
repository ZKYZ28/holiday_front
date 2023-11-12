part of 'invitation_bloc.dart';

abstract class InvitationState extends Equatable {
  const InvitationState();

  @override
  List<Object?> get props => [];
}

class InvitationInitial extends InvitationState {}

class InvitationLoading extends InvitationState {}

class InvitationLoaded extends InvitationState {
  final List<Invitation>? invitationsList;

  const InvitationLoaded(this.invitationsList);
}

class InvitationError extends InvitationState {
  final String? message;
  const InvitationError(this.message);
}