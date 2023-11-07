import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:holiday_mobile/presentation/widgets/common/icon_with_text.dart';

@RoutePage()
class Activity extends StatefulWidget {
  const Activity({super.key});

  @override
  State<Activity> createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Nom de l\'activité ici'),
      ),

      body: Center(
          child: IntrinsicHeight(
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          margin: const EdgeInsets.all(20),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.asset(
                  "assets/images/bgHoliday.jpg",
                  fit: BoxFit.cover,
                ),
              ),

              /**
                   * Container(
                      height: 200,
                      child: Image.asset(
                      "assets/images/bgHoliday.jpg",
                      fit: BoxFit.cover, // Ajuste l'image pour remplir la largeur sans déformation
                      ),
                      )
                   */

              Container(
                margin: const EdgeInsets.fromLTRB(15, 20, 0, 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: const Text(
                        'Monaco 2023',
                        style: TextStyle(
                          fontSize: 22,
                          color: Color(0xFF1E3A8A),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.logout,
                            color: Colors.blue,
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.edit,
                            color: Colors.blue,
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Confirmation"),
                                  content: const Text(
                                      "Etes-vous sûr de vouloir supprimer cette activité ?"),
                                  actions: [
                                    ButtonBar(
                                      alignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Fermer la popup
                                          },
                                          child: const Text("Annuler"),
                                        ),
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context)
                                                .pop(); // Fermer la popup
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
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(15, 20, 0, 10),
                // Marge pour le Text
                child: const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam tincidunt arcu diam.",
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    iconWithText(Icons.calendar_month, '30/03/2022'),
                    iconWithText(Icons.euro, '10.00'),
                    iconWithText(Icons.location_on, 'Monaco'),
                    iconWithText(Icons.people_sharp, '4'),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3A8A),
                      ),
                      icon: const Icon(Icons.group),
                      label: const Text("Participants"),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF1E3A8A),
                      ),
                      icon: const Icon(Icons.location_on),
                      label: const Text("S'y rendre"),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      )),
    );
  }
}
