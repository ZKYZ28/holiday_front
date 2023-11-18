part of 'participant_bloc.dart';

enum ParticipantStateStatus {initial, loading, loaded, error, added, left}

class ParticipantState extends Equatable{
  final ParticipantStateStatus status;
  final List<Participant>? participantsList;
  final String errorMessage;

  const ParticipantState({
    this.status = ParticipantStateStatus.initial,
    this.participantsList = const [],
    this.errorMessage = ""
  });

  ParticipantState copyWith({
    ParticipantStateStatus? status,
    List<Participant>? participantsList,
    String? errorMessage
  }) {
    return ParticipantState(
        status : status ?? this.status,
        participantsList: participantsList ?? this.participantsList,
        errorMessage : errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object?> get props => [status, participantsList, errorMessage];
}