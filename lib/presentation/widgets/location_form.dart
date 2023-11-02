import 'package:flutter/material.dart';

class LocationForm extends StatelessWidget {
  const LocationForm({super.key});

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
      ]
    );
  }
}