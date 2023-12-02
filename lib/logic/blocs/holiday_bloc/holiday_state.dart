part of 'holiday_bloc.dart';

enum HolidayStateStatus {initial, loading, loaded, error, published, waitingActivityAction, left}

class HolidayState extends Equatable {
  final HolidayStateStatus status;
  final List<Holiday> holidaysList;
  final List<Participant>? participantsList;
  final Holiday? holidayItem;
  final String? errorMessage;

  const HolidayState({
    this.status = HolidayStateStatus.initial,
    this.holidaysList = const [],
    this.participantsList = const [],
    this.holidayItem,
    this.errorMessage = "",
  });

  HolidayState copyWith({
    HolidayStateStatus? status,
    List<Holiday>? holidaysList,
    List<Participant>? participantsList,
    Holiday? holidayItem,
    String? errorMessage
  }) {
    return HolidayState(
        status : status ?? this.status,
        holidaysList: holidaysList ?? this.holidaysList,
        participantsList: participantsList ?? this.participantsList,
        holidayItem: holidayItem ?? this.holidayItem,
        errorMessage : errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object?> get props => [status, holidaysList, participantsList, holidayItem, errorMessage];

}