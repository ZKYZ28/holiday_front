part of 'holiday_bloc.dart';

enum HolidayStateStatus {initial, loading, loaded, error, published, waitingActivityAction}

class HolidayState extends Equatable {
  final HolidayStateStatus status;
  final List<Holiday> holidaysList;
  final Holiday? holidayItem;
  final String? errorMessage;

  const HolidayState({
    this.status = HolidayStateStatus.initial,
    this.holidaysList = const [],
    this.holidayItem,
    this.errorMessage = "",
  });

  HolidayState copyWith({
    HolidayStateStatus? status,
    List<Holiday>? holidaysList,
    Holiday? holidayItem,
    String? errorMessage
  }) {
    return HolidayState(
        status : status ?? this.status,
        holidaysList: holidaysList ?? this.holidaysList,
        holidayItem: holidayItem ?? holidayItem,
        errorMessage : errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object?> get props => [status, holidaysList, holidayItem, errorMessage];

}