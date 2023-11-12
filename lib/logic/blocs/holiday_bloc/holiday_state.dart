part of 'holiday_bloc.dart';

abstract class HolidayState extends Equatable {
  const HolidayState();

  @override
  List<Object?> get props => [];
}

class HolidayInitial extends HolidayState {}

class HolidayLoading extends HolidayState {}

class HolidayLoaded extends HolidayState {
  final List<Holiday>? holidaysList;
  final Holiday? holidayItem;

  const HolidayLoaded({this.holidaysList, this.holidayItem});

  const HolidayLoaded.list(List<Holiday> holidays) : holidaysList = holidays, holidayItem = null;
  const HolidayLoaded.item(Holiday holiday) : holidayItem = holiday, holidaysList = null;
}

class HolidayError extends HolidayState {
  final String? message;
  const HolidayError(this.message);
}