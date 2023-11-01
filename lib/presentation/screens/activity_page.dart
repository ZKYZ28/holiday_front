import 'package:flutter/material.dart';

class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.all(10),
        child: Container(
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Spacer(), // Pour mettre les éléments à droite
                  IconButton(
                    onPressed: () {

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
                                      // TODO: ACTION DE SUPPRESSION
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
                    child: Image.asset("assets/images/bgHoliday.jpg"),
                  ),
                  Flexible(
                    flex: 3, // La colonne occupe 3 parts sur 5 (60%)
                    child: Container(
                      margin: EdgeInsets.only(left: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                            child: const Text(
                              'Monaco 2023',
                              style: TextStyle(
                                fontSize: 22,
                                color: Color(0xFF1E3A8A),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          rowHolidayCard(Icons.calendar_month, '30/03/2022-27/09/2023'),
                          rowHolidayCard(Icons.people_sharp, '4'),
                          rowHolidayCard(Icons.location_on, 'Monaco'),
                        ],
                      ),
                    ),
                  )
                ],
              ),

              Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 10), // Marge pour le Text
                child: const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam tincidunt arcu diam.",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


Container rowHolidayCard(IconData icon, String text) {
  return Container(
    margin: EdgeInsets.only(bottom: 8.0),
    child: Row(
      children: [
        Icon(icon),
        SizedBox(width: 8.0),
        Text(
          text,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}