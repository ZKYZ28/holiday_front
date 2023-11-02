import 'package:flutter/material.dart';
import 'package:holiday_mobile/presentation/screens/encode_holiday.dart';

class HolidaysPage extends StatefulWidget {
  const HolidaysPage({super.key});

  @override
  State<HolidaysPage> createState() => _HolidaysPageState();
}

class _HolidaysPageState extends State<HolidaysPage> {

  final holidaysList = [
    {
      "name": "Monaco 2023",
      "description": "On va bien s'amuser",
      "img": "bgHoliday"
    },
    {
      "name": "Monaco 2024",
      "description": "On va encore bien s'amuser",
      "img": "bgHoliday"
    },
    {
      "name": "Monaco 2025",
      "description": "On va encore encore bien s'amuser",
      "img": "bgHoliday"
    }
  ];


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child:  Text(
                'Mes vacances',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  padding: const MaterialStatePropertyAll(EdgeInsets.only(left: 10, right: 10)),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Color(0xFF1E3A8A);
                      }
                      return Color(0xFF1E3A8A);
                    },
                  ),
                ),
                icon: Icon(Icons.add),
                label: const Text('Encoder'),
                onPressed: () {
                  Navigator.push(
                      context,
                      PageRouteBuilder(
                          pageBuilder: (_, __, ___) => EncodeHoliday()
                      )
                  );
                },
              ),
            ),
          ],
        ),

        Expanded(
          child: ListView.builder(
            itemCount: holidaysList.length,
            itemBuilder: (context, index) {
              final holiday = holidaysList[index];
              final bgHoliday = holiday['img'];
              final name = holiday['name'];
              final description = holiday['description'];

              return Card(
                margin: EdgeInsets.all(10),
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Spacer(), // Pour mettre les éléments à droite
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
              );

            },
          ),
        ),
      ],
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