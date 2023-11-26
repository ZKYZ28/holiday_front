part of 'location_bloc.dart';


abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class LocationCountryChanged extends LocationEvent {
  final String coutry;
  const LocationCountryChanged({required this.coutry});
  @override
  List<Object> get props => [coutry];
}

class LocationNumberBoxChanged extends LocationEvent {
  final String? numberBox;
  const LocationNumberBoxChanged({required this.numberBox});
  @override
  List<Object> get props => [numberBox ?? ""];
}

class LocationStreetChanged extends LocationEvent {
  final String? street;
  const LocationStreetChanged({required this.street});
  @override
  List<Object> get props => [street ?? ""];
}

class LocationLocalityChanged extends LocationEvent {
  final String? locality;
  const LocationLocalityChanged({required this.locality});
  @override
  List<Object> get props => [locality ?? ""];
}

class LocationPostalCodeChanged extends LocationEvent {
  final String? postalCode;
  const LocationPostalCodeChanged({required this.postalCode});
  @override
  List<Object> get props => [postalCode ?? ""];
}




