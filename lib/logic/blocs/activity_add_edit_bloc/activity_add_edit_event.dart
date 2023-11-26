part of 'activity_add_edit_bloc.dart';

abstract class ActivityAddEditEvent extends Equatable {
  const ActivityAddEditEvent();

  @override
  List<Object> get props => [];
}

class ActivityNameChanged extends ActivityAddEditEvent {
  final String name;
  const ActivityNameChanged({required this.name});

  @override
  List<Object> get props => [name];
}

class ActivityPriceChanged extends ActivityAddEditEvent {
  // Bien que l'on reçoit un prix, le textFormField renvoie un string
  final String price;
  const ActivityPriceChanged({required this.price});

  @override
  List<Object> get props => [price];
}

class ActivityDateStartChanged extends ActivityAddEditEvent {
  final DateTime? start;
  const ActivityDateStartChanged({required this.start});

  @override
  List<Object> get props => [start ?? DateTime.now()];
}

class ActivityDateEndChanged extends ActivityAddEditEvent {
  final DateTime? end;
  const ActivityDateEndChanged({required this.end});

  @override
  List<Object> get props => [end ?? DateTime.now()];
}

class ActivityDescriptionChanged extends ActivityAddEditEvent {
  final String description;
  const ActivityDescriptionChanged({required this.description});

  @override
  List<Object> get props => [description];
}


class ActivityFileChanged extends ActivityAddEditEvent {
  final File? file;
  final bool deleteFile;
  const ActivityFileChanged({required this.file, this.deleteFile = false});

  @override
  List<Object> get props => [file ?? NoFile()];
}

class ActivitySumbit extends ActivityAddEditEvent {
  final String holidayId;
  const ActivitySumbit({required this.holidayId});
  @override
  List<Object> get props => [holidayId];
}

class ActivityEditSubmit extends ActivityAddEditEvent {
  final String holidayId;
  final String activityId;
  final String activityPath;
  final String locationId;

  const ActivityEditSubmit({required this.holidayId, required this.activityId, required this.activityPath, required this.locationId});

  @override
  List<Object> get props => [holidayId, activityId, activityPath, locationId];
}


