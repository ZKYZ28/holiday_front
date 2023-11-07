import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:holiday_mobile/presentation/widgets/common/icon_with_text.dart';
import 'package:holiday_mobile/routes/app_router.gr.dart';

class HolidayCard extends StatelessWidget {
  final String name;
  final String description;
  final String pathUrl;

  HolidayCard({required this.name, required this.description, required this.pathUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(), // Pour mettre les éléments à droite
                IconButton(
                  onPressed: () {
                    // Action d'édition
                    context.router.push(const MyHolidayRoute());
                  },
                  icon: const Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Confirmation"),
                          content: const Text("Etes-vous sûr de vouloir supprimer cette vacance ?"),
                          actions: [
                            ButtonBar(
                              alignment: MainAxisAlignment.spaceAround,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Fermer la popup
                                  },
                                  child: const Text("Annuler"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // TODO ACTION DE SUPPRESSION
                                    Navigator.of(context).pop(); // Fermer la popup
                                  },
                                  child: const Text("Supprimer"),
                                ),
                              ],
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                ),
              ],
            ),

            Row(
              children: [
                Flexible(
                  flex: 2, // La partie image occupe 2 parts sur 5 (40%)
                 // child: Image.asset("assets/images/bgHoliday.jpg"),
                 child: Image.network('https://10.0.2.2:7048/${pathUrl}'),
                ),
                Flexible(
                  flex: 3, // La colonne occupe 3 parts sur 5 (60%)
                  child: Container(
                    margin: const EdgeInsets.only(left: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                          child: Text(
                            name,
                            style: const TextStyle(
                              fontSize: 22,
                              color: Color(0xFF1E3A8A),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        iconWithText(Icons.calendar_month, '30/03/2022-27/09/2023'),
                        iconWithText(Icons.people_sharp, '4'),
                        iconWithText(Icons.location_on, 'Monaco'),
                      ],
                    ),
                  ),
                )
              ],
            ),
            Container(
              margin: const EdgeInsets.fromLTRB(0, 10, 0, 10), // Marge pour le Text
              child: Text(
                description,
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),
    );
  }
}