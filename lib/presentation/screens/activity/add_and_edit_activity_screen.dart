import 'package:auto_route/auto_route.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:holiday_mobile/data/models/activity/activity.dart';
import 'package:holiday_mobile/data/providers/authentification_api_provider.dart';
import 'package:holiday_mobile/data/repositories/authentification_api_repository.dart';
import 'package:holiday_mobile/logic/blocs/activity_add_edit_bloc/activity_add_edit_bloc.dart';
import 'package:holiday_mobile/logic/blocs/common/class_form/holiday_and_activity_class_state.dart';
import 'package:holiday_mobile/logic/blocs/holiday_bloc/holiday_bloc.dart';
import 'package:holiday_mobile/logic/blocs/location/location_bloc.dart';
import 'package:holiday_mobile/presentation/widgets/common/GenericInputField.dart';
import 'package:holiday_mobile/presentation/widgets/common/custom_message.dart';
import 'package:holiday_mobile/presentation/widgets/common/image_picker.dart';
import 'package:holiday_mobile/presentation/widgets/location/location_form.dart';
import 'package:auto_route/annotations.dart';
import 'dart:io';

import 'package:intl/intl.dart';

@RoutePage()
class EncodeActivityScreen extends StatefulWidget {
  final String holidayId;
  final Activity? activity;

  const EncodeActivityScreen(
      {super.key, @PathParam() required this.holidayId, this.activity});

  @override
  State<EncodeActivityScreen> createState() => _EncodeActivityScreenState();
}

class _EncodeActivityScreenState extends State<EncodeActivityScreen> {
  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.activity != null;
    return MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => LocationBloc(editLocation: isEditMode && widget.activity?.location != null ? widget.activity!.location : null)),
          BlocProvider(
              create: (context) => ActivityAddEditBloc(
                  locationBloc: BlocProvider.of<LocationBloc>(context),
                  authRepository: AuthRepository(
                      RepositoryProvider.of<AuthAPiProvider>(context)),
                editActivity: isEditMode ? widget.activity : null
              ))
        ],
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF1E3A8A),
            title: const Text('Encoder une activité'),
          ),
          body: BlocConsumer<ActivityAddEditBloc, ActivityAddEditState>(
            listener: (context, state) {
              if (state.activityAddEditStatus.isFailure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentMaterialBanner()
                  ..showMaterialBanner(
                      CustomMessage(message: "${state.errorMessage}")
                          .build(context));
              }
              if (state.activityAddEditStatus.isSuccess) {
                context.router.pop(true);
              }
            },
            builder: (context, state) {
              // On s'assure que les nouveaux blocs sont créés grâce à ce nouveau contexte
              return buildEncodeEditActivityForm(context);
            },
          ),
        ));
  }

  Widget buildEncodeEditActivityForm(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                margin: const EdgeInsets.only(bottom: 30),
                child: const Text(
                  'Encoder une activité',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 10),
                child: Form(
                  child: Column(
                    children: [
                      ImagePickerForm(
                        initialPath: widget.activity != null
                            ? widget.activity!.activityPath
                            : null,
                        onImagePicked: (pickedImage, deleteImage) {
                          context.read<ActivityAddEditBloc>().add(
                              ActivityFileChanged(
                                  file: pickedImage, deleteFile: deleteImage));
                        },
                      ),
                      BlocBuilder<ActivityAddEditBloc, ActivityAddEditState>(
                        buildWhen: (previous, current) =>
                            previous.fileWithStatus.file !=
                                current.fileWithStatus.file ||
                            previous.fileWithStatus.customStatus !=
                                current.fileWithStatus.customStatus,
                        builder: (context, state) {
                          if (state.fileWithStatus.customStatus ==
                                  CustomStatus.invalid &&
                              state.errorMessage!.isNotEmpty) {
                            return Text(
                              state.errorMessage ?? '',
                              style: const TextStyle(color: Colors.red),
                            );
                          }
                          return Container();
                        },
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin:
                                  const EdgeInsets.only(bottom: 10, right: 10),
                              child: GenericInputField<ActivityAddEditBloc,
                                  ActivityAddEditState>(
                                buildWhen: (previous, current) =>
                                    previous.name != current.name,
                                initialValue: widget.activity != null
                                    ? widget.activity!.name
                                    : '',
                                labelText: 'Nom *',
                                hintText: 'Randonnée',
                                onChanged: (name) => context
                                    .read<ActivityAddEditBloc>()
                                    .add(ActivityNameChanged(name: name)),
                                errorText: (state) =>
                                    !state.name.isPure && state.name.isNotValid
                                        ? state.errorMessage
                                        : null,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin:
                                  const EdgeInsets.only(bottom: 10, left: 10),
                              child: GenericInputField<ActivityAddEditBloc,
                                  ActivityAddEditState>(
                                buildWhen: (previous, current) =>
                                    previous.price != current.price,
                                initialValue: widget.activity != null
                                    ? widget.activity!.price.toString()
                                    : '',
                                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                                labelText: 'Prix *',
                                hintText: '10.00',
                                onChanged: (price) => context
                                    .read<ActivityAddEditBloc>()
                                    .add(ActivityPriceChanged(price: price)),
                                errorText: (state) => !state.price.isPure &&
                                        state.price.isNotValid
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
                              margin:
                                  const EdgeInsets.only(right: 10, bottom: 10),
                              child: BlocBuilder<ActivityAddEditBloc,
                                  ActivityAddEditState>(
                                buildWhen: (previous, current) => previous.start.dateTime != current.start.dateTime || previous.start.customStatus != current.start.customStatus,
                                builder: (context, state) {
                                  return DateTimeFormField(
                                    decoration: const InputDecoration(
                                      hintStyle:
                                          TextStyle(color: Colors.black45),
                                      errorStyle:
                                          TextStyle(color: Colors.redAccent),
                                      border: OutlineInputBorder(),
                                      suffixIcon: Icon(Icons.event_note),
                                      labelText: 'Date de début',
                                    ),
                                    dateFormat: DateFormat('dd/MM/yyyy HH:mm'),
                                    initialValue: state.start.dateTime,
                                    mode: DateTimeFieldPickerMode.dateAndTime,
                                    onDateSelected: (DateTime value) {
                                      context.read<ActivityAddEditBloc>().add(ActivityDateStartChanged(start: value));
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              margin:
                                  const EdgeInsets.only(left: 10, bottom: 10),
                              child: BlocBuilder<ActivityAddEditBloc,
                                  ActivityAddEditState>(
                                buildWhen: (previous, current) => previous.end.dateTime != current.end.dateTime || previous.end.customStatus != current.end.customStatus,
                                builder: (context, state) {
                                  return DateTimeFormField(
                                    decoration: const InputDecoration(
                                      hintStyle:
                                      TextStyle(color: Colors.black45),
                                      errorStyle:
                                      TextStyle(color: Colors.redAccent),
                                      border: OutlineInputBorder(),
                                      suffixIcon: Icon(Icons.event_note),
                                      labelText: 'Date de fin',
                                    ),
                                    dateFormat: DateFormat('dd/MM/yyyy HH:mm'),
                                    initialValue: state.end.dateTime,
                                    mode: DateTimeFieldPickerMode.dateAndTime,
                                    onDateSelected: (DateTime value) {
                                      context.read<ActivityAddEditBloc>().add(ActivityDateEndChanged(end: value));
                                    },
                                  );
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                      BlocBuilder<ActivityAddEditBloc, ActivityAddEditState>(
                        buildWhen: (previous, current) => previous.start.dateTime != current.start.dateTime || previous.start.customStatus != current.start.customStatus || previous.end.dateTime != current.end.dateTime || previous.end.customStatus != current.end.customStatus,
                        builder: (context, state) {
                          print(state.start.customStatus);
                          print(state.end.customStatus);
                          if ((state.start.customStatus ==
                              CustomStatus.invalid && state.end.customStatus == CustomStatus.invalid) &&
                              state.errorMessage!.isNotEmpty) {
                            return Container(
                              margin: EdgeInsets.only(bottom: 10.0),
                              child: Text(
                                state.errorMessage ?? '',
                                style: const TextStyle(color: Colors.red),
                              ),
                            );
                          }
                          return Container();
                        },
                      ),
                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: GenericInputField<ActivityAddEditBloc,
                            ActivityAddEditState>(
                          buildWhen: (previous, current) =>
                          previous.description != current.description,
                          initialValue: widget.activity != null
                              ? widget.activity!.description
                              : '',
                          labelText: 'Description *',
                          hintText: 'Le lundi au soleil',
                          onChanged: (description) => context
                              .read<ActivityAddEditBloc>()
                              .add(ActivityDescriptionChanged(description: description)),
                          errorText: (state) =>
                          !state.description.isPure && state.description.isNotValid
                              ? state.errorMessage
                              : null,
                        ),
                      ),
                      LocationForm(location: widget.activity != null ? widget.activity!.location : null),
                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {
                            if(widget.activity != null) {
                              context.read<ActivityAddEditBloc>().add(ActivityEditSubmit(holidayId: widget.holidayId, activityId: widget.activity!.id!, activityPath: widget.activity!.activityPath, locationId: widget.activity!.location.id!));
                            //  context.read<HolidayBloc>().add(GetHoliday(holidayId: widget.holidayId));
                            } else {
                              context.read<ActivityAddEditBloc>().add(ActivitySumbit(holidayId: widget.holidayId));
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E3A8A),
                          ),
                          child: const Text("Encoder"),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
