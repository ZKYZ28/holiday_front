import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/models/location/location.dart';
import 'package:holiday_mobile/logic/blocs/location/location_bloc.dart';
import 'package:holiday_mobile/presentation/widgets/common/GenericInputField.dart';

class LocationForm extends StatelessWidget {
  Location? location;
  LocationForm({super.key, this.location});

  @override
  Widget build(BuildContext context) {
    return Column(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 15, bottom: 10),
            child: const Text(
              'Lieu',
              style: TextStyle(
                  fontSize: 18,
                  color: Color(0xFF1E3A8A),
                  fontWeight: FontWeight.bold
              ),
            ),
          ),

          Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: GenericInputField<LocationBloc, LocationState>(
              buildWhen: (previous, current) =>
              previous.country != current.country,
              initialValue: location != null ? location!.country : '',
              labelText: 'Pays *',
              hintText:
              'Belgique',
              onChanged: (pays) => context
                  .read<LocationBloc>()
                  .add(LocationCountryChanged(coutry: pays)),
              errorText: (state) => !state.country.isPure &&
                  state.country.isNotValid
                  ? state.errorMessage
                  : null,
            )
          ),

          Row(
            children: [

              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10, right: 10),
                  child: GenericInputField<LocationBloc, LocationState>(
                    buildWhen: (previous, current) =>
                    previous.numberBox != current.numberBox,
                    initialValue: location != null ? location!.number : '',
                    labelText: 'Numéro de boîte ',
                    hintText:
                    '7',
                    onChanged: (numberBox) => context
                        .read<LocationBloc>()
                        .add(LocationNumberBoxChanged(numberBox: numberBox)),
                    errorText: (state) => !state.numberBox.isPure &&
                        state.numberBox.isNotValid
                        ? state.errorMessage
                        : null,
                  )
                ),
              ),

              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10, left: 10),
                  child: GenericInputField<LocationBloc, LocationState>(
                    buildWhen: (previous, current) =>
                    previous.street != current.street,
                    initialValue: location != null ? location!.street : '',
                    labelText: 'Rue ',
                    hintText:
                    'Rue de Harlez',
                    onChanged: (street) => context
                        .read<LocationBloc>()
                        .add(LocationStreetChanged(street: street)),
                    errorText: (state) => !state.street.isPure &&
                        state.street.isNotValid
                        ? state.errorMessage
                        : null,
                  ),
                ),
              ),
            ],
          ),

          Row(
            children: [

              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10, right: 10),
                  child: GenericInputField<LocationBloc, LocationState>(
                    buildWhen: (previous, current) =>
                    previous.postalCode != current.postalCode,
                    initialValue: location != null ? location!.postalCode : '',
                    labelText: 'Code postal *',
                    hintText:
                    '4000',
                    onChanged: (postalCode) => context
                        .read<LocationBloc>()
                        .add(LocationPostalCodeChanged(postalCode: postalCode)),
                    errorText: (state) => !state.postalCode.isPure &&
                        state.postalCode.isNotValid
                        ? state.errorMessage
                        : null,
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 10, left: 10),
                  child: GenericInputField<LocationBloc, LocationState>(
                    buildWhen: (previous, current) =>
                    previous.locality != current.locality,
                    initialValue: location != null ? location!.locality : '',
                    labelText: 'Ville *',
                    hintText:
                    'Liège',
                    onChanged: (locality) => context
                        .read<LocationBloc>()
                        .add(LocationLocalityChanged(locality: locality)),
                    errorText: (state) => !state.locality.isPure &&
                        state.locality.isNotValid
                        ? state.errorMessage
                        : null,
                  ),
                ),
              ),
            ],
          ),
      ]
    );
  }
}