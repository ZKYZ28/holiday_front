part of 'invitation_bloc.dart';

enum InvitationStateStatus {initial, loading, loaded, error, accepted, sent}

class InvitationState extends Equatable {
  final InvitationStateStatus status;
  final List<Invitation> invitationsList;
  final String? errorMessage;

  const InvitationState({
    this.status = InvitationStateStatus.initial,
    this.invitationsList = const [],
    this.errorMessage = "",
  });

  InvitationState copyWith({
    InvitationStateStatus? status,
    List<Invitation>? invitationsList,
    String? errorMessage
  }) {
    return InvitationState(
        status : status ?? this.status,
        invitationsList: invitationsList ?? this.invitationsList,
        errorMessage : errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object?> get props => [status, invitationsList, errorMessage];

}