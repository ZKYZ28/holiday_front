import 'package:flutter/material.dart';
import 'package:holiday_mobile/presentation/widgets/holiday_tile.dart';

class ListHolidaysChat extends StatefulWidget {
  const ListHolidaysChat({super.key});

  @override
  State<ListHolidaysChat> createState() => _ListHolidaysChatState();
}

class _ListHolidaysChatState extends State<ListHolidaysChat> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        Container(
          margin: const EdgeInsets.all(15),
          child: const Text(
            'Mes groupes de vacances',
            style:  TextStyle(
              fontSize: 22, // Taille de la police
              fontWeight: FontWeight.bold, // Poids de la police
              letterSpacing: 1.5, // Espacement entre les caractères
            ),
          ),
        ),

        Expanded(
          child: ListView(
            children: <Widget>[
              HolidayTile(
                onTap: () {
                  print("clique");
                },
              ),

              HolidayTile(
                onTap: () {
                  print("clique");
                },
              ),

              HolidayTile(
                onTap: () {
                  print("clique");
                },
              )

            ],
          ),
        ),
      ],
    );
  }
}
