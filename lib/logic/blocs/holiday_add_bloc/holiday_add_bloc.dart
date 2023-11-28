import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:holiday_mobile/data/models/holiday/holiday.dart';
import 'package:holiday_mobile/data/providers/data/HolidayData.dart';
import 'package:holiday_mobile/data/providers/data/LocationData.dart';
import 'package:holiday_mobile/data/repositories/authentification_api_repository.dart';
import 'package:holiday_mobile/data/repositories/holiday_api_repository.dart';
import 'package:holiday_mobile/data/services/date/date_service.dart';
import 'package:holiday_mobile/data/services/picture/picture_service.dart';
import 'package:holiday_mobile/logic/blocs/common/class_form/holiday_and_activity_class_state.dart';
import 'package:holiday_mobile/logic/blocs/holiday_add_bloc/validators/holiday_add_description.dart';
import 'package:holiday_mobile/logic/blocs/holiday_add_bloc/validators/holiday_add_name.dart';
import 'package:holiday_mobile/logic/blocs/location/location_bloc.dart';
import 'package:holiday_mobile/main.dart';
import 'package:meta/meta.dart';
import 'package:timezone/timezone.dart';

part 'holiday_add_event.dart';

part 'holiday_add_state.dart';

class HolidayAddBloc extends Bloc<HolidayAddEvent, HolidayAddState> {
  final LocationBloc locationBloc;
  StreamSubscription? locationSubscription;
  late LocationState _locationState;
  // TODO : donner dans le constructeur
  final HolidayApiRepository _holidayRepository = HolidayApiRepository();
  late AuthRepository authRepository;

  HolidayAddBloc({required this.locationBloc, required this.authRepository, Holiday? editHoliday}) : super(editHoliday == null ? HolidayAddState() : HolidayAddState.initialData(editHoliday)) {
    _locationState = locationBloc.state;
    on<HolidayAddNameChanged>(_onNameChanged);
    on<HolidayAddDateStartChanged>(_onStartDateChanged);
    on<HolidayAddDateEndChanged>(_onEndDateChanged);
    on<HolidayAddDescriptionChanged>(_onDescriptionChanged);
    on<HolidayAddFileChanged>(_onFileChanged);
    on<HolidayAddSubmit>(_onHolidayAddFormSubmit);
    on<HolidayEditSubmit>(_onHolidayEditFormSubmit);

    locationSubscription = locationBloc.stream.listen((locationState) {
      _locationState = locationState;
      print(locationState.country);
      print(locationState.postalCode);
    });
  }


  void _onNameChanged(
      HolidayAddNameChanged event, Emitter<HolidayAddState> emit) {
    final name = HolidayNameInput.dirty(value: event.name);
    emit(state.copyWith(
        holidayAddStatus: FormzSubmissionStatus.inProgress,
        name: name,
        errorMessage: name.error?.message));
  }

  void _onStartDateChanged(
      HolidayAddDateStartChanged event, Emitter<HolidayAddState> emit) {
    final newStartDate = DateService.convertDateTimeToTzDateTime(event.start, globalLocation!);
    final endDate = state.end.dateTime;
    if(!event.isEditMode && !DateService.isStartDateValid(newStartDate, false)) {
      emit(state.copyWith(
          holidayAddStatus: FormzSubmissionStatus.inProgress,
          start: DateTimeWithStatus(dateTime: newStartDate, customStatus: CustomStatus.invalid),
          end: DateTimeWithStatus(dateTime: endDate, customStatus: CustomStatus.invalid),
          errorMessage: "La date de début doit être supérieure ou égale à la date actuelle")
      );
      return;
    }
    if(!DateService.isEndDateValid(newStartDate, DateService.convertTzDateTimeToDateTime(endDate), false)) {
      emit(state.copyWith(
          holidayAddStatus: FormzSubmissionStatus.inProgress,
          start: DateTimeWithStatus(dateTime: newStartDate, customStatus: CustomStatus.invalid),
          end : DateTimeWithStatus(dateTime: endDate, customStatus: CustomStatus.invalid),
          errorMessage: "La date de fin doit être supérieure à la date de début.")
      );
      return;
    }
    emit(state.copyWith(
        holidayAddStatus: FormzSubmissionStatus.inProgress,
        start: DateTimeWithStatus(dateTime: newStartDate, customStatus: CustomStatus.valid),
        end: DateTimeWithStatus(dateTime: endDate, customStatus: CustomStatus.valid),
        errorMessage: null,
    ));
  }

  void _onEndDateChanged(
      HolidayAddDateEndChanged event, Emitter<HolidayAddState> emit) {
    final newEndDate = DateService.convertDateTimeToTzDateTime(event.end, globalLocation!);
    final startDate = state.start.dateTime;
    if(!DateService.isEndDateValid(DateService.convertTzDateTimeToDateTime(startDate), newEndDate, false)) {
      emit(state.copyWith(
          holidayAddStatus: FormzSubmissionStatus.inProgress,
          start: DateTimeWithStatus(dateTime: startDate, customStatus: CustomStatus.invalid),
          end : DateTimeWithStatus(dateTime: newEndDate, customStatus: CustomStatus.invalid),
          errorMessage: "La date de fin doit être supérieure à la date de début.")
      );
      return;
    }
    emit(state.copyWith(
      holidayAddStatus: FormzSubmissionStatus.inProgress,
      start: DateTimeWithStatus(dateTime: startDate, customStatus: CustomStatus.valid),
      end: DateTimeWithStatus(dateTime: newEndDate, customStatus: CustomStatus.valid),
      errorMessage: null,
    ));
  }

  void _onDescriptionChanged(
      HolidayAddDescriptionChanged event, Emitter<HolidayAddState> emit) {
    final description = DescriptionHolidayInput.dirty(value: event.description);
    emit(state.copyWith(
        holidayAddStatus: FormzSubmissionStatus.inProgress,
        description: description,
        errorMessage: description.error?.message));
  }

  void _onFileChanged(
      HolidayAddFileChanged event, Emitter<HolidayAddState> emit) {
    File? file = event.file;
    if (file == null) {
      emit(state.copyWith(
          fileWithStatus: FileWithStatus(file: null, customStatus: CustomStatus.valid, deleteImage: event.deleteFile),
          errorMessage: "Aucune image sélectionnée !"));
      return;
    }
    try {
      if (!PictureService.isAllowedType(
          file.path.split('.').last.toLowerCase())) {
        emit(state.copyWith(
            holidayAddStatus: FormzSubmissionStatus.inProgress,
            fileWithStatus: FileWithStatus(file: file, customStatus: CustomStatus.invalid, deleteImage: event.deleteFile),
            errorMessage:
                "Veuillez sélectionner un fichier au format PNG, JPG ou JPEG."));
        return;
      }
      if (PictureService.isHigherFiveMo(file.lengthSync())) {
        state.copyWith(
            holidayAddStatus: FormzSubmissionStatus.inProgress,
            fileWithStatus: FileWithStatus(file: file, customStatus: CustomStatus.invalid, deleteImage: event.deleteFile),
            errorMessage: "La taille du fichier dépasse la limite de 5 Mo");
        return;
      }
      print('NEW FILE VALUE : ${file.path}');
      emit(state.copyWith(
          holidayAddStatus: FormzSubmissionStatus.inProgress,
          fileWithStatus: FileWithStatus(file: file, customStatus: CustomStatus.valid, deleteImage: event.deleteFile),
          errorMessage: null));
    } catch (e) {
      state.copyWith(
          holidayAddStatus: FormzSubmissionStatus.inProgress,
          fileWithStatus: FileWithStatus(file: file, customStatus: CustomStatus.invalid, deleteImage: event.deleteFile),
          errorMessage: "Un problème est survenu avec la gestion des images");
    }
  }

  void _onHolidayAddFormSubmit(HolidayAddSubmit event, Emitter<HolidayAddState> emit) async {
    emit(state.copyWith(holidayAddStatus: FormzSubmissionStatus.inProgress));

    if(state.formIsValid && _locationState.formIsValid) {
      final startDate = state.start.dateTime;
      final endDate = state.end.dateTime;
      print('LOCATION DATA BLOC : ${_locationState.street.value}');
      try {
        await _holidayRepository.createHoliday(
          HolidayData(
          name:  state.name.value,
          description:  state.description.value,
          startDate: DateTime(startDate.year, startDate.month, startDate.day),
          endDate: DateTime(endDate.year, endDate.month, endDate.day),
          file:  state.fileWithStatus.file,
          locationData: LocationData(
              country: _locationState.country.value,
              locality: _locationState.locality.value,
              street: _locationState.street.value,
              postalCode: _locationState.postalCode.value,
              numberBox: _locationState.numberBox.value,
          ),
          creatorId: authRepository.userConnected!.id
        )
        );
        emit(state.copyWith(holidayAddStatus: FormzSubmissionStatus.success));
      } catch (e) {
        emit(state.copyWith(holidayAddStatus: FormzSubmissionStatus.failure, errorMessage: e.toString()));
      }
    } else {
      emit(state.copyWith(holidayAddStatus: FormzSubmissionStatus.failure, errorMessage: "Tous les champs de ne sont pas valides ! Veillez à compléter tous les champs obligatoires (*) ou lire les messages d'erreur sous chaque champ."));
    }
  }

  void _onHolidayEditFormSubmit(HolidayEditSubmit event, Emitter<HolidayAddState> emit) async {
    emit(state.copyWith(holidayAddStatus: FormzSubmissionStatus.inProgress));

    if(state.formIsValid && _locationState.formIsValid) {
      final startDate = state.start.dateTime;
      final endDate = state.end.dateTime;
      print(_locationState.street.value);
      try {
        await _holidayRepository.updateHoliday(
            HolidayData(
                name:  state.name.value,
                description:  state.description.value,
                startDate: DateTime(startDate.year, startDate.month, startDate.day),
                endDate: DateTime(endDate.year, endDate.month, endDate.day),
                file:  state.fileWithStatus.file,
                locationData: LocationData(
                  locationId: event.locationId,
                  country:  _locationState.country.value,
                  locality: _locationState.locality.value,
                  street:  _locationState.street.value,
                  postalCode: _locationState.postalCode.value,
                  numberBox:  _locationState.numberBox.value,
                ),
                creatorId: authRepository.userConnected!.id,
                deleteImage: state.fileWithStatus.deleteImage,
                initialPath: event.holidayPath,
                holidayId: event.holidayId,
            )
        );
        emit(state.copyWith(holidayAddStatus: FormzSubmissionStatus.success));
      } catch (e) {
        emit(state.copyWith(holidayAddStatus: FormzSubmissionStatus.failure, errorMessage: e.toString()));
      }
    } else {
      emit(state.copyWith(holidayAddStatus: FormzSubmissionStatus.failure, errorMessage: "Tous les champs de ne sont pas valides ! Veillez à compléter tous les champs obligatoires (*) ou lire les messages d'erreur sous chaque champ."));
    }
  }

  @override
  Future<void> close() {
    locationSubscription?.cancel();
    return super.close();
  }

}
