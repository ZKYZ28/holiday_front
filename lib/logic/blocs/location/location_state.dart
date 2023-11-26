part of 'location_bloc.dart';


class LocationState extends Equatable {

  final FormzSubmissionStatus locationStatus;
  final CountryInput country;
  final NumberBoxInput numberBox;
  final StreetInput street;
  final LocalityInput locality;
  final PostalCodeInput postalCode;
  final String? errorMessage;

  const LocationState({
    this.locationStatus = FormzSubmissionStatus.initial,
    this.country = const CountryInput.pure(),
    this.numberBox = const NumberBoxInput.pure(),
    this.street = const StreetInput.pure(),
    this.locality = const LocalityInput.pure(),
    this.postalCode = const PostalCodeInput.pure(),
    this.errorMessage = ""
  });

  factory LocationState.initialData(Location location) {
    return LocationState(
      locationStatus: FormzSubmissionStatus.initial,
      country: CountryInput.dirty(value: location.country),
      locality: LocalityInput.dirty(value: location.locality),
      postalCode: PostalCodeInput.dirty(value: location.postalCode),
      street: StreetInput.dirty(value: location.street),
      numberBox: NumberBoxInput.dirty(value: location.number),
      errorMessage: ""
    );
  }

  LocationState copyWith({
    FormzSubmissionStatus? locationStatus,
    CountryInput? country,
    NumberBoxInput? numberBox,
    StreetInput? street,
    LocalityInput? locality,
    PostalCodeInput? postalCode,
    String? errorMessage,
  }) {
    return LocationState(
      locationStatus : locationStatus ?? this.locationStatus,
      country: country ?? this.country,
      numberBox: numberBox ?? this.numberBox,
      street: street ?? this.street,
      locality: locality ?? this.locality,
      postalCode: postalCode ?? this.postalCode,
      errorMessage: errorMessage ?? this.errorMessage
    );
  }

  bool get formIsValid => country.isValid && numberBox.isValid && street.isValid && locality.isValid && postalCode.isValid;

  @override
  List<Object?> get props => [locationStatus, country, numberBox, street, locality, postalCode, errorMessage ?? ""];

}


