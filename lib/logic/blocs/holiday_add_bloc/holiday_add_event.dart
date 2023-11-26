part of 'holiday_add_bloc.dart';


abstract class HolidayAddEvent extends Equatable {
  const HolidayAddEvent();

  @override
  List<Object> get props => [];
}

class HolidayAddNameChanged extends HolidayAddEvent {
  final String name;
  const HolidayAddNameChanged({required this.name});

  @override
  List<Object> get props => [name];
}

class HolidayAddDateStartChanged extends HolidayAddEvent {
  final DateTime? start;
  const HolidayAddDateStartChanged({required this.start});

  @override
  List<Object> get props => [start ?? DateTime.now()];
}

class HolidayAddDateEndChanged extends HolidayAddEvent {
  final DateTime? end;
  const HolidayAddDateEndChanged({required this.end});

  @override
  List<Object> get props => [end ?? DateTime.now()];
}

class HolidayAddDescriptionChanged extends HolidayAddEvent {
  final String description;
  const HolidayAddDescriptionChanged({required this.description});

  @override
  List<Object> get props => [description];
}

class HolidayAddFileChanged extends HolidayAddEvent {
  final File? file;
  final bool deleteFile;
  const HolidayAddFileChanged({required this.file, this.deleteFile = false});

  @override
  List<Object> get props => [file ?? NoFile(), deleteFile];
}


class HolidayAddSubmit extends HolidayAddEvent {
  const HolidayAddSubmit();
}

class HolidayEditSubmit extends HolidayAddEvent {
  final String holidayId;
  final String holidayPath;
  final String locationId;

  const HolidayEditSubmit({required this.holidayId, required this.holidayPath, required this.locationId});

  @override
  List<Object> get props => [holidayId, holidayPath, locationId];
}
