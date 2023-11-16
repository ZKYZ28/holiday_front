part of 'participate_bloc.dart';

enum ParticipateStateStatus {initial, loading, loaded, error, added, left, sent}

class ParticipateState extends Equatable{
  final ParticipateStateStatus status;
  final List<Participate>? participatesList;
  final String errorMessage;

  const ParticipateState({
    this.status = ParticipateStateStatus.initial,
    this.participatesList = const [],
    this.errorMessage = ""
  });

  ParticipateState copyWith({
    ParticipateStateStatus? status,
    List<Participate>? participatesList,
    String? errorMessage
  }) {
    return ParticipateState(
        status : status ?? this.status,
        participatesList: participatesList ?? this.participatesList,
        errorMessage : errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object?> get props => [status, participatesList, errorMessage];
}