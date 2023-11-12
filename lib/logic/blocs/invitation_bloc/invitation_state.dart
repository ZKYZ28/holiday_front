part of 'invitation_bloc.dart';

enum InvitationStateStatus {initial, loading, loaded, error}

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

// abstract class InvitationState extends Equatable {
//   const InvitationState();
//
//   @override
//   List<Object?> get props => [];
// }
//
// class InvitationInitial extends InvitationState {}
//
// class InvitationLoading extends InvitationState {}
//
// class InvitationLoaded extends InvitationState {
//   final List<Invitation>? invitationsList;
//
//   const InvitationLoaded(this.invitationsList);
// }
//
// class InvitationError extends InvitationState {
//   final String? message;
//   const InvitationError(this.message);
// }