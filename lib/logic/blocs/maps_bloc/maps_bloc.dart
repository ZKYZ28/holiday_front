import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

import '../../../data/models/location/location.dart';


part 'maps_event.dart';
part 'maps_state.dart';


class MapsBloc extends Bloc<MapsEvent, MapsState> {

  MapsBloc() : super(const MapsState()) {

    on<GetCoordFromAddress>((GetCoordFromAddress event, emit) async {
      try {

        final address = event.address;
        List<geocoding.Location> geocodedLocations = await Location.locationsFromAddress(address);

        emit(state.copyWith(status: MapsStatus.loaded,latitude: geocodedLocations[0].latitude, longitude: geocodedLocations[0].longitude));

      } on Exception catch (e) {
        emit(state.copyWith(status: MapsStatus.error, errorMessage : e.toString()));
      }
    });
  }
}