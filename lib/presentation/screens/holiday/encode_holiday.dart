import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:holiday_mobile/presentation/widgets/common/image_picker.dart';
import 'package:holiday_mobile/presentation/widgets/location/location_form.dart';
import 'dart:io';
import 'package:auto_route/annotations.dart';

@RoutePage()
class EncodeHoliday extends StatefulWidget {
  const EncodeHoliday({super.key});

  @override
  State<EncodeHoliday> createState() => _EncodeHolidayState();
}

class _EncodeHolidayState extends State<EncodeHoliday> {
  File? _image;

  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  @override
  void dispose() {
    super.dispose();

    nameController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1E3A8A),
        title: const Text('Encoder une vacance'),
      ),

      body: Center(
        child: Container(
          margin: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ImagePickerForm(
                    onImagePicked: (pickedImage) {
                      _image = pickedImage;
                    },
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child: TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(
                        labelText: 'Nom *',
                        hintText: '',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Le champ ne peut pas être vide";
                        }
                        return null;
                      },
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(right: 10, bottom: 10),
                          child: DateTimeFormField(
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.black45),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.event_note),
                              labelText: 'Date de début',
                            ),
                            mode: DateTimeFieldPickerMode.dateAndTime,
                            autovalidateMode: AutovalidateMode.disabled,
                            validator: (e) {
                              if (e == null) {
                                return 'Sélectionnez une date';
                              }

                              final now = DateTime.now();
                              if (e.isBefore(now)) {
                                return 'La date ne peut pas être antérieure à aujourd\'hui';
                              }

                              return null;
                            },
                            onDateSelected: (value){
                              startDate = value;
                            }
                          )
                        ),
                      ),
                      Expanded(
                        child: Container(
                          margin: const EdgeInsets.only(left: 10, bottom: 10),
                          child: DateTimeFormField(
                            decoration: const InputDecoration(
                              hintStyle: TextStyle(color: Colors.black45),
                              errorStyle: TextStyle(color: Colors.redAccent),
                              border: OutlineInputBorder(),
                              suffixIcon: Icon(Icons.event_note),
                              labelText: 'Date de fin',
                            ),
                            mode: DateTimeFieldPickerMode.dateAndTime,
                            autovalidateMode: AutovalidateMode.disabled,
                            validator: (e) {
                              if (e == null) {
                                return 'Sélectionnez une date';
                              }

                              final now = DateTime.now();
                              if (e.isBefore(now)) {
                                return 'La date ne peut pas être antérieure à aujourd\'hui';
                              }

                              return null;
                            },

                            onDateSelected: (value){
                              endDate = value;
                            }
                          ),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    child:  TextFormField(
                      controller: descriptionController,
                      maxLines: 4,
                      decoration: const InputDecoration(
                        labelText: 'Description *',
                        hintText: 'Saisissez votre description...',
                        border: OutlineInputBorder(),
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Le champ ne peut pas être vide";
                        }
                        return null;
                      },
                    ),
                  ),
                  const LocationForm(),
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    child: ElevatedButton(
                      onPressed: () {

                        if (_formKey.currentState?.validate() == true) {

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
        ),
      ),
    );
  }
}