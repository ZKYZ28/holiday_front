part of 'activity_add_edit_bloc.dart';

class ActivityAddEditState extends Equatable {

  final FormzSubmissionStatus activityAddEditStatus;
  final ActivityNameInput name;
  late  final DateTimeWithStatus start;
  late final DateTimeWithStatus end;
  late final FileWithStatus fileWithStatus;
  final ActivityDescriptionInput description;
  final ActivityPriceInput price;
  final String? errorMessage;

  ActivityAddEditState({
    this.activityAddEditStatus = FormzSubmissionStatus.initial,
    this.name = const ActivityNameInput.pure(),
    DateTimeWithStatus? start,
    DateTimeWithStatus? end,
    FileWithStatus? fileWithStatus,
    this.description = const ActivityDescriptionInput.pure(),
    this.price = const ActivityPriceInput.pure(),
    this.errorMessage = "",
  }) {
    this.start = start ?? DateTimeWithStatus(customStatus: CustomStatus.init);
    this.end = end ?? DateTimeWithStatus(customStatus: CustomStatus.init);
    this.fileWithStatus = fileWithStatus ?? FileWithStatus();
  }

  factory ActivityAddEditState.initialData(Activity activity) {
    TZDateTime startDate = TZDateTime.parse(globalLocation!, activity.startDate);
    TZDateTime endDate = TZDateTime.parse(globalLocation!, activity.endDate);

    return ActivityAddEditState(
      activityAddEditStatus: FormzSubmissionStatus.initial,
      name: ActivityNameInput.dirty(value: activity.name),
      description: ActivityDescriptionInput.dirty(value: activity.description),
      price: ActivityPriceInput.dirty(value: activity.price.toString()),
      fileWithStatus: FileWithStatus(file: null, customStatus: CustomStatus.valid, deleteImage: false),
      start: DateTimeWithStatus(dateTime: startDate, customStatus: CustomStatus.valid),
      end: DateTimeWithStatus(dateTime: endDate, customStatus: CustomStatus.valid),
      errorMessage: "",
    );
  }

  ActivityAddEditState copyWith({
    FormzSubmissionStatus? activityAddEditStatus,
    ActivityNameInput? name,
    DateTimeWithStatus? start,
    DateTimeWithStatus? end,
    FileWithStatus? fileWithStatus,
    ActivityDescriptionInput? description,
    ActivityPriceInput? price,
    String? errorMessage
  }) {
    return ActivityAddEditState(
      activityAddEditStatus: activityAddEditStatus ?? this.activityAddEditStatus,
      price: price ?? this.price,
      name : name ?? this.name,
      start: start ?? this.start,
      end: end ?? this.end,
      fileWithStatus : fileWithStatus ?? this.fileWithStatus,
      description: description ?? this.description,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  bool get formIsValid => name.isValid && description.isValid && price.isValid && (fileWithStatus.customStatus == CustomStatus.valid || fileWithStatus.customStatus == CustomStatus.init)  && (start.customStatus == CustomStatus.valid || start.customStatus == CustomStatus.init) && (end.customStatus == CustomStatus.valid || end.customStatus == CustomStatus.init);

  @override
  List<Object?> get props => [activityAddEditStatus, name, price, start.customStatus, start.dateTime, end.customStatus, end.dateTime, fileWithStatus.customStatus, fileWithStatus.file, description, errorMessage];
}

