import 'package:auto_route/auto_route.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:holiday_mobile/data/models/holiday/holiday.dart';
import 'package:holiday_mobile/data/providers/authentification_api_provider.dart';
import 'package:holiday_mobile/data/repositories/authentification_api_repository.dart';
import 'package:holiday_mobile/logic/blocs/holiday_add_bloc/holiday_add_bloc.dart';
import 'package:holiday_mobile/logic/blocs/location/location_bloc.dart';
import 'package:holiday_mobile/logic/common/class_form/holiday_and_activity_class_state.dart';
import 'package:holiday_mobile/presentation/widgets/common/GenericInputField.dart';
import 'package:holiday_mobile/presentation/widgets/common/custom_message.dart';
import 'package:holiday_mobile/presentation/widgets/common/image_picker.dart';
import 'package:holiday_mobile/presentation/widgets/location/location_form.dart';
import 'package:auto_route/annotations.dart';
import 'package:intl/intl.dart';

@RoutePage()
class EncodeHoliday extends StatefulWidget {

  final Holiday? holiday;
  const EncodeHoliday({super.key, this.holiday});

  @override
  State<EncodeHoliday> createState() => _EncodeHolidayState();
}

class _EncodeHolidayState extends State<EncodeHoliday> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.holiday != null;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocationBloc(editLocation: isEditMode && widget.holiday?.location != null ? widget.holiday!.location : null)),
        BlocProvider(
            create: (context) => HolidayAddBloc(
                locationBloc: BlocProvider.of<LocationBloc>(context),
                authRepository: AuthRepository(RepositoryProvider.of<AuthAPiProvider>(context)),
                editHoliday: isEditMode ? widget.holiday : null
            ))
      ],
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF1E3A8A),
          title: const Text('Encoder un séjour'),
        ),
        body: BlocConsumer<HolidayAddBloc, HolidayAddState>(
          listener: (context, state) {
            if (state.holidayAddStatus.isFailure) {
              ScaffoldMessenger.of(context)
                ..hideCurrentMaterialBanner()
                ..showMaterialBanner(
                    CustomMessage(message: "${state.errorMessage}")
                        .build(context));
            }
            if (state.holidayAddStatus.isSuccess) {
              context.router.pop();
            }
          },
          builder: (context, state) {
            return buildEncodeHolidayForm(context);
          },
        ),
      ),
    );
  }

  Widget buildEncodeHolidayForm(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ImagePickerForm(
                  initialPath: widget.holiday != null ? widget.holiday!.holidayPath : null,
                  onImagePicked: (pickedImage, deleteImage) {
                    context
                        .read<HolidayAddBloc>()
                        .add(HolidayAddFileChanged(file: pickedImage, deleteFile: deleteImage));
                  },
                ),
                BlocBuilder<HolidayAddBloc, HolidayAddState>(
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
                Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: GenericInputField<HolidayAddBloc, HolidayAddState>(
                      buildWhen: (previous, current) =>
                          previous.name != current.name,
                      initialValue: widget.holiday != null ? widget.holiday!.name : '',
                      labelText: 'Nom *',
                      hintText: 'Monaco Juillet 2023',
                      onChanged: (name) => context.read<HolidayAddBloc>().add(HolidayAddNameChanged(name: name)),
                      errorText: (state) =>
                          !state.name.isPure && state.name.isNotValid
                              ? state.errorMessage
                              : null,
                    )),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                          margin: const EdgeInsets.only(right: 10, bottom: 10),
                          child: BlocBuilder<HolidayAddBloc, HolidayAddState>(
                            buildWhen: (previous, current) => previous.start.dateTime != current.start.dateTime,
                            builder: (context, state) {
                              return DateTimeFormField(
                                  decoration: const InputDecoration(
                                    hintStyle: TextStyle(color: Colors.black45),
                                    errorStyle:
                                        TextStyle(color: Colors.redAccent),
                                    border: OutlineInputBorder(),
                                    suffixIcon: Icon(Icons.event_note),
                                    labelText: 'Date de début *',
                                  ),
                                  mode: DateTimeFieldPickerMode.date,
                                  dateFormat: DateFormat('dd/MM/yyyy'),
                                  initialValue: state.start.dateTime,
                                  onDateSelected: (value) {
                                    context.read<HolidayAddBloc>().add(HolidayAddDateStartChanged(start: value, isEditMode: widget.holiday != null));
                                  });
                            },
                          )),
                    ),
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 10, bottom: 10),
                        child: BlocBuilder<HolidayAddBloc, HolidayAddState>(
                          buildWhen: (previous, current) => previous.end.dateTime != current.end.dateTime,
                          builder: (context, state) {
                            return DateTimeFormField(
                                decoration:  const InputDecoration(
                                  hintStyle: TextStyle(color: Colors.black45),
                                  errorStyle:
                                      TextStyle(color: Colors.redAccent),
                                  border: OutlineInputBorder(),
                                  suffixIcon: Icon(Icons.event_note),
                                  labelText: 'Date de fin *',
                                ),
                                dateFormat: DateFormat('dd/MM/yyyy'),
                                mode: DateTimeFieldPickerMode.date,
                                initialValue: state.end.dateTime,
                                onDateSelected: (value) {
                                  context.read<HolidayAddBloc>().add(HolidayAddDateEndChanged(end: value));
                                });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                BlocBuilder<HolidayAddBloc, HolidayAddState>(
                  buildWhen: (previous, current) => previous.start.dateTime != current.start.dateTime || previous.start.customStatus != current.start.customStatus || previous.end.dateTime != current.end.dateTime || previous.end.customStatus != current.end.customStatus,
                  builder: (context, state) {
                    if ((state.start.customStatus ==
                        CustomStatus.invalid && state.end.customStatus == CustomStatus.invalid) &&
                        state.errorMessage!.isNotEmpty) {
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10.0),
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
                    child: GenericInputField<HolidayAddBloc, HolidayAddState>(
                      buildWhen: (previous, current) =>
                          previous.description != current.description,
                      initialValue: widget.holiday != null ? widget.holiday!.description : '',
                      labelText: 'Description',
                      hintText:
                          'Notre voyage dans une belle ville remplie de montres de luxe.',
                      onChanged: (description) => context
                          .read<HolidayAddBloc>()
                          .add(HolidayAddDescriptionChanged(
                              description: description)),
                      errorText: (state) => !state.description.isPure &&
                              state.description.isNotValid
                          ? state.errorMessage
                          : null,
                    )),
                 LocationForm(location : widget.holiday != null ? widget.holiday!.location : null),
                Container(
                  margin: const EdgeInsets.only(top: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      widget.holiday != null ? context.read<HolidayAddBloc>().add(HolidayEditSubmit( holidayId: widget.holiday!.id ?? '', holidayPath: widget.holiday!.holidayPath, locationId : widget.holiday!.location.id ?? '')) : context.read<HolidayAddBloc>().add(const HolidayAddSubmit());
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
      ),
    );
  }
}
