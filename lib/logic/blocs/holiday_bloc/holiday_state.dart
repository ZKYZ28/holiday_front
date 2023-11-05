part of 'holiday_bloc.dart';

abstract class HolidayState extends Equatable {
  const HolidayState();

  @override
  List<Object?> get props => [];
}

class HolidayInitial extends HolidayState {}

class HolidayLoading extends HolidayState {}

class HolidayLoaded extends HolidayState {
  final Holiday holiday;
  const HolidayLoaded(this.holiday);
}

class HolidayError extends HolidayState {
  final String? message;
  const HolidayError(this.message);
}