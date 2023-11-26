part of 'holiday_add_bloc.dart';

class HolidayAddState extends Equatable {
    final FormzSubmissionStatus holidayAddStatus;
    final HolidayNameInput name;
    late final DateTimeWithStatus start;
    late final DateTimeWithStatus end;
    late final FileWithStatus fileWithStatus;
    final DescriptionHolidayInput description;
    final String? errorMessage;
    //final bool isEditMode;

    HolidayAddState({
      this.holidayAddStatus = FormzSubmissionStatus.initial,
      this.name = const HolidayNameInput.pure(),
      DateTimeWithStatus? start,
      DateTimeWithStatus? end,
      FileWithStatus? fileWithStatus,
      this.description = const DescriptionHolidayInput.pure(),
      this.errorMessage = "",
     // this.isEditMode = false,
  }) {
      this.start = start ?? DateTimeWithStatus(dateTime: TZDateTime.now(globalLocation!));
      this.end = end ?? DateTimeWithStatus(dateTime: TZDateTime.now(globalLocation!).add(const Duration(days: 7)));
      this.fileWithStatus = fileWithStatus ?? FileWithStatus();
    }

    factory HolidayAddState.initialData(Holiday holiday) {
      TZDateTime startDate = TZDateTime.parse(globalLocation!, holiday.startDate);
      print(startDate);
      TZDateTime endDate = TZDateTime.parse(globalLocation!, holiday.endDate);
      print(endDate);
      return HolidayAddState(
       // isEditMode: true,
        holidayAddStatus: FormzSubmissionStatus.initial,
        description: DescriptionHolidayInput.dirty(value: holiday.description),
        name: HolidayNameInput.dirty(value: holiday.name),
        fileWithStatus: FileWithStatus(file: null, customStatus: CustomStatus.valid, deleteImage: false),
        start: DateTimeWithStatus(dateTime: startDate, customStatus: CustomStatus.valid),
        end: DateTimeWithStatus(dateTime: endDate, customStatus: CustomStatus.valid),
        errorMessage: "",
      );
    }

    HolidayAddState copyWith({
      FormzSubmissionStatus? holidayAddStatus,
      HolidayNameInput? name,
      DateTimeWithStatus? start,
      DateTimeWithStatus? end,
      FileWithStatus? fileWithStatus,
      DescriptionHolidayInput? description,
      String? errorMessage
    }) {
      return HolidayAddState(
        holidayAddStatus: holidayAddStatus ?? this.holidayAddStatus,
        name : name ?? this.name,
        start: start ?? this.start,
        end: end ?? this.end,
        fileWithStatus : fileWithStatus ?? this.fileWithStatus,
        description: description ?? this.description,
        errorMessage: errorMessage ?? this.errorMessage,
      );
    }

    bool get formIsValid => name.isValid && description.isValid && (fileWithStatus.customStatus == CustomStatus.valid || fileWithStatus.customStatus == CustomStatus.init)  && (start.customStatus == CustomStatus.valid || start.customStatus == CustomStatus.init) && (end.customStatus == CustomStatus.valid || end.customStatus == CustomStatus.init);

  @override
  List<Object?> get props => [holidayAddStatus, name, start.customStatus, start.dateTime, end.customStatus, end.dateTime, fileWithStatus.customStatus, fileWithStatus.file, description, errorMessage];

}
