import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:holiday_mobile/presentation/widgets/image_picker.dart';
import 'package:holiday_mobile/presentation/widgets/location_form.dart';
import 'package:auto_route/annotations.dart';
import 'dart:io';

@RoutePage()
class EncodeActivity extends StatefulWidget {
  const EncodeActivity({super.key});

  @override
  State<EncodeActivity> createState() => _EncodeActivityState();
}

class _EncodeActivityState extends State<EncodeActivity> {
  File? _image;

  @override
  Widget build(BuildContext context) {
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
                        onImagePicked: (pickedImage) {
                          print(pickedImage);
                        },
                      ),

                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10, right: 10),
                              child: TextFormField(
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
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 10, left: 10),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Prix *',
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
                          ),
                        ],
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
                                autovalidateMode: AutovalidateMode.always,
                                validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                                onDateSelected: (DateTime value) {

                                },
                              ),
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
                                autovalidateMode: AutovalidateMode.always,
                                validator: (e) => (e?.day ?? 0) == 1 ? 'Please not the first day' : null,
                                onDateSelected: (DateTime value) {
                                  // Code de gestion de la date de fin
                                },
                              ),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: const TextField(
                          maxLines: 4,
                          decoration: InputDecoration(
                            labelText: 'Description *',
                            hintText: 'Saisissez votre description...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),

                      LocationForm(),

                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {

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
