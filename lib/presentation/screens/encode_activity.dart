import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

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

                      Container(
                        margin: const EdgeInsets.only(bottom: 10),
                        child: _image == null
                            ? const Text('Aucune image sélectionnée')
                            : Column(
                          children: [
                            SizedBox(
                              width: 200, // Largeur souhaitée
                              height: 200, // Hauteur souhaitée
                              child: Image.file(_image!),
                            ),
                            IconButton(
                              icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red
                              ),
                              onPressed: () {
                                setState(() {
                                  _image = null;
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                      Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        child: ElevatedButton(
                          onPressed: () async {
                            final imagePicker = ImagePicker();
                            final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

                            if (pickedFile != null) {
                              setState(() {
                                _image = File(pickedFile.path);
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1E3A8A),
                          ),
                          child: const Text(
                              'Sélectionner une image'

                          ),
                        ),
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
                          maxLines: 4, // Réglez le nombre de lignes souhaité
                          decoration: InputDecoration(
                            labelText: 'Description *',
                            hintText: 'Saisissez votre description...',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),

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
                        child: TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'Pays *',
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
                              margin: const EdgeInsets.only(bottom: 10, right: 10),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Numéro de boite *',
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
                                  labelText: 'Rue *',
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
                              margin: const EdgeInsets.only(bottom: 10, right: 10),
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  labelText: 'Code postal *',
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
                                  labelText: 'Ville *',
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


                      Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: ElevatedButton(
                          onPressed: () {

                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color(0xFF1E3A8A),
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
