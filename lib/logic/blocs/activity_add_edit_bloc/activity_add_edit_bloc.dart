import 'dart:async';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:holiday_mobile/data/models/activity/activity.dart';
import 'package:holiday_mobile/data/providers/data/ActivityData.dart';
import 'package:holiday_mobile/data/providers/data/LocationData.dart';
import 'package:holiday_mobile/data/repositories/activity_api_repository.dart';
import 'package:holiday_mobile/data/repositories/authentification_api_repository.dart';
import 'package:holiday_mobile/data/services/date/date_service.dart';
import 'package:holiday_mobile/data/services/picture/picture_service.dart';
import 'package:holiday_mobile/logic/blocs/activity_add_edit_bloc/validators/activity_add_edit_description.dart';
import 'package:holiday_mobile/logic/blocs/activity_add_edit_bloc/validators/activity_add_edit_name.dart';
import 'package:holiday_mobile/logic/blocs/activity_add_edit_bloc/validators/activity_add_edit_price.dart';
import 'package:holiday_mobile/logic/blocs/common/class_form/holiday_and_activity_class_state.dart';
import 'package:holiday_mobile/logic/blocs/holiday_add_bloc/holiday_add_bloc.dart';
import 'package:holiday_mobile/logic/blocs/location/location_bloc.dart';
import 'package:holiday_mobile/main.dart';
import 'package:meta/meta.dart';
import 'package:timezone/timezone.dart';

part 'activity_add_edit_event.dart';
part 'activity_add_edit_state.dart';

class ActivityAddEditBloc extends Bloc<ActivityAddEditEvent, ActivityAddEditState> {
  final LocationBloc locationBloc;
  StreamSubscription? locationSubscription;
  late LocationState _locationState;
  final ActivityApiRepository _activityRepository = ActivityApiRepository();
  late AuthRepository authRepository;

  ActivityAddEditBloc({required this.locationBloc, required this.authRepository, Activity? editActivity}) : super(editActivity == null ? ActivityAddEditState() : ActivityAddEditState.initialData(editActivity)) {
    // S'assurer que l'état du locationBloc soit défini avant utilisation la première fois
    _locationState = locationBloc.state;

    on<ActivityNameChanged>(_onNameChanged);
    on<ActivityPriceChanged>(_onPriceChanged);
    on<ActivityDateStartChanged>(_onStartDateChanged);
    on<ActivityDateEndChanged>(_onEndDateChanged);
    on<ActivityDescriptionChanged>(_onDescriptionChanged);
    on<ActivityFileChanged>(_onFileChanged);
    on<ActivitySumbit>(_onActivityAddFormSubmit);
    on<ActivityEditSubmit>(_onActivityEditFormSubmit);

    locationSubscription = locationBloc.stream.listen((locationState) {
      _locationState = locationState;
    });
  }


  void _onNameChanged(ActivityNameChanged event, Emitter<ActivityAddEditState> emit) {
    final name = ActivityNameInput.dirty(value: event.name);
    emit(state.copyWith(
      activityAddEditStatus: FormzSubmissionStatus.inProgress,
      name: name,
      errorMessage: name.error?.message
    ));
  }

  void _onPriceChanged(ActivityPriceChanged event, Emitter<ActivityAddEditState> emit) {
    final price = ActivityPriceInput.dirty(value: event.price);
    emit(state.copyWith(
      activityAddEditStatus: FormzSubmissionStatus.inProgress,
      price: price,
      errorMessage: price.error?.message
    ));
  }

  void _onStartDateChanged(ActivityDateStartChanged event, Emitter<ActivityAddEditState> emit) {
    final newStartDate = DateService.convertDateTimeToTzDateTime(event.start, globalLocation!, considerTime: true);
    final endDate = state.end.dateTime;

    if(!DateService.isEndDateValid(newStartDate, DateService.convertTzDateTimeToDateTime(endDate, considerTime: true), true)) {
      emit(state.copyWith(
        activityAddEditStatus: FormzSubmissionStatus.inProgress,
        start: DateTimeWithStatus(dateTime: newStartDate, customStatus: CustomStatus.invalid),
        end: DateTimeWithStatus(dateTime: endDate, customStatus: CustomStatus.invalid),
        errorMessage: "La date de fin doit être supérieure à la date de début."
      ));
      return;
    }
    // Date valide
    emit(state.copyWith(
    activityAddEditStatus: FormzSubmissionStatus.inProgress,
      start: DateTimeWithStatus(dateTime: newStartDate, customStatus: CustomStatus.valid),
      end: DateTimeWithStatus(dateTime: endDate, customStatus: CustomStatus.valid),
    errorMessage: null,
    ));
  }

  void _onEndDateChanged(ActivityDateEndChanged event, Emitter<ActivityAddEditState> emit) {
    final startDate = state.start.dateTime;
    final newEndDate = DateService.convertDateTimeToTzDateTime(event.end, globalLocation!, considerTime: true);

    if (!DateService.isEndDateValid(DateService.convertTzDateTimeToDateTime(startDate, considerTime : true), newEndDate, true)) {
      emit(state.copyWith(
          activityAddEditStatus: FormzSubmissionStatus.inProgress,
          start: DateTimeWithStatus(dateTime: startDate, customStatus: CustomStatus.invalid),
          end: DateTimeWithStatus(dateTime: newEndDate, customStatus: CustomStatus.invalid),
          errorMessage: "La date de fin doit être supérieure à la date de début."
      ));
      return;
    }
    emit(state.copyWith(
      activityAddEditStatus: FormzSubmissionStatus.inProgress,
      start: DateTimeWithStatus(dateTime: startDate, customStatus: CustomStatus.valid),
      end: DateTimeWithStatus(dateTime: newEndDate, customStatus: CustomStatus.valid),
      errorMessage: null,
    ));
  }

  void _onDescriptionChanged(ActivityDescriptionChanged event, Emitter<ActivityAddEditState> emit) {
    final description = ActivityDescriptionInput.dirty(value: event.description);
    emit(state.copyWith(
        activityAddEditStatus: FormzSubmissionStatus.inProgress,
        description: description,
        errorMessage: description.error?.message
    ));
  }



  void _onFileChanged(ActivityFileChanged event, Emitter<ActivityAddEditState> emit) {
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
            activityAddEditStatus: FormzSubmissionStatus.inProgress,
            fileWithStatus: FileWithStatus(file: file, customStatus: CustomStatus.invalid, deleteImage: event.deleteFile),
            errorMessage:
            "Veuillez sélectionner un fichier au format PNG, JPG ou JPEG."));
        return;
      }
      if (PictureService.isHigherFiveMo(file.lengthSync())) {
        state.copyWith(
            activityAddEditStatus: FormzSubmissionStatus.inProgress,
            fileWithStatus: FileWithStatus(file: file, customStatus: CustomStatus.invalid, deleteImage: event.deleteFile),
            errorMessage: "La taille du fichier dépasse la limite de 5 Mo");
        return;
      }
      emit(state.copyWith(
          activityAddEditStatus: FormzSubmissionStatus.inProgress,
          fileWithStatus: FileWithStatus(file: file, customStatus: CustomStatus.valid, deleteImage: event.deleteFile),
          errorMessage: null));
    } catch (e) {
      state.copyWith(activityAddEditStatus: FormzSubmissionStatus.inProgress,
          fileWithStatus: FileWithStatus(file: file, customStatus: CustomStatus.invalid, deleteImage: event.deleteFile),
          errorMessage: "Un problème est survenu avec la gestion des images");
    }
  }



  void _onActivityAddFormSubmit(ActivitySumbit event, Emitter<ActivityAddEditState> emit) async {
    emit(state.copyWith(activityAddEditStatus: FormzSubmissionStatus.inProgress));

    if(state.formIsValid && _locationState.formIsValid) {
      try {
        await _activityRepository.createActivity(
          ActivityData(
            name: state.name.value,
            description: state.description.value,
            price: double.parse(state.price.value),
            startDate: DateService.convertTzDateTimeToDateTime(state.start.dateTime, considerTime: true),
            endDate: DateService.convertTzDateTimeToDateTime(state.end.dateTime, considerTime: true),
            file: state.fileWithStatus.file,
            holidayId: event.holidayId,
            locationData: LocationData(
              country: _locationState.country.value,
              locality: _locationState.locality.value,
              street: _locationState.street.value,
              postalCode: _locationState.postalCode.value,
              numberBox: _locationState.numberBox.value
            )
          )
        );
        emit(state.copyWith(activityAddEditStatus: FormzSubmissionStatus.success));
      } catch (e) {
        emit(state.copyWith(activityAddEditStatus: FormzSubmissionStatus.failure, errorMessage: e.toString()));
      }
    } else {
      emit(state.copyWith(activityAddEditStatus: FormzSubmissionStatus.failure, errorMessage: "Tous les champs de ne sont pas valides ! Veillez à compléter tous les champs obligatoires (*) ou lire les messages d'erreur sous chaque champ. "));
    }

  }



  void _onActivityEditFormSubmit(ActivityEditSubmit event, Emitter<ActivityAddEditState> emit) async {
    emit(state.copyWith(activityAddEditStatus: FormzSubmissionStatus.inProgress));

    if(state.formIsValid && _locationState.formIsValid) {
      try {
        await _activityRepository.updateActivity(
            ActivityData(
                name: state.name.value,
                description: state.description.value,
                price: double.parse(state.price.value),
                startDate: DateService.convertTzDateTimeToDateTime(state.start.dateTime, considerTime: true),
                endDate: DateService.convertTzDateTimeToDateTime(state.end.dateTime, considerTime: true),
                file: state.fileWithStatus.file,
                holidayId: event.holidayId,
                locationData: LocationData(
                  locationId: event.locationId,
                    country: _locationState.country.value,
                    locality: _locationState.locality.value,
                    street: _locationState.street.value,
                    postalCode: _locationState.postalCode.value,
                    numberBox: _locationState.numberBox.value),
                deleteImage: state.fileWithStatus.deleteImage,
                initialPath: event.activityPath,
                activityId: event.activityId,


            )
        );
        emit(state.copyWith(activityAddEditStatus: FormzSubmissionStatus.success));
      } catch (e) {
        emit(state.copyWith(activityAddEditStatus: FormzSubmissionStatus.failure, errorMessage: e.toString()));
      }
    } else {
      emit(state.copyWith(activityAddEditStatus: FormzSubmissionStatus.failure, errorMessage: "Tous les champs de ne sont pas valides ! Veillez à compléter tous les champs obligatoires (*) ou lire les messages d'erreur sous chaque champ."));
    }
  }

  @override
  Future<void> close() {
    locationSubscription?.cancel();
    return super.close();
  }

}
