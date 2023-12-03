import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:holiday_mobile/data/models/location/location.dart';
import 'package:holiday_mobile/logic/blocs/location/validators/country.dart';
import 'package:holiday_mobile/logic/blocs/location/validators/locality.dart';
import 'package:holiday_mobile/logic/blocs/location/validators/numberBox.dart';
import 'package:holiday_mobile/logic/blocs/location/validators/postalCode.dart';
import 'package:holiday_mobile/logic/blocs/location/validators/street.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {

  LocationBloc({Location? editLocation}) : super(editLocation == null ?  const LocationState() : LocationState.initialData(editLocation)) {
    on<LocationCountryChanged>(_onCountryChanged);
    on<LocationNumberBoxChanged>(_onNumberBoxChanged);
    on<LocationStreetChanged>(_onStreetChanged);
    on<LocationLocalityChanged>(_onLocalityChanged);
    on<LocationPostalCodeChanged>(_onPostalCodeChanged);
  }

  void _onCountryChanged(LocationCountryChanged event, Emitter<LocationState> emit) {
    final country = CountryInput.dirty(value : event.country);
    emit(state.copyWith(
      locationStatus: FormzSubmissionStatus.inProgress,
      country: country,
      errorMessage: country.error?.message
    ));
  }

  void _onNumberBoxChanged(LocationNumberBoxChanged event, Emitter<LocationState> emit) {
    final numberBox = NumberBoxInput.dirty(value : event.numberBox ?? '');
    emit(state.copyWith(
        locationStatus: FormzSubmissionStatus.inProgress,
        numberBox: numberBox,
        errorMessage: numberBox.error?.message
    ));
  }

  void _onStreetChanged(LocationStreetChanged event, Emitter<LocationState> emit) {
    final street = StreetInput.dirty(value : event.street ?? '');
    emit(state.copyWith(
        locationStatus: FormzSubmissionStatus.inProgress,
        street: street,
        errorMessage: street.error?.message
    ));
  }

  void _onLocalityChanged(LocationLocalityChanged event, Emitter<LocationState> emit) {
    final locality = LocalityInput.dirty(value : event.locality ?? '');
    emit(state.copyWith(
        locationStatus: FormzSubmissionStatus.inProgress,
        locality: locality,
        errorMessage: locality.error?.message
    ));
  }

  void _onPostalCodeChanged(LocationPostalCodeChanged event, Emitter<LocationState> emit) {
    final postalCode = PostalCodeInput.dirty(value : event.postalCode ?? '');
    emit(state.copyWith(
        locationStatus: FormzSubmissionStatus.inProgress,
        postalCode: postalCode,
        errorMessage: postalCode.error?.message
    ));
  }
}
