import 'package:flutter/material.dart';
import 'package:holiday_mobile/presentation/screens/encode_holiday.dart';
import 'package:holiday_mobile/presentation/widgets/holiday_card.dart';

class HolidaysPage extends StatefulWidget {
  const HolidaysPage({super.key});

  @override
  State<HolidaysPage> createState() => _HolidaysPageState();
}

class _HolidaysPageState extends State<HolidaysPage> {
  bool isToggled = false;

  final holidaysList = [
    {
      "name": "Monaco 2023",
      "description": "On va bien s'amuser",
    },
    {
      "name": "Monaco 2024",
      "description": "On va encore bien s'amuser",
    },
    {
      "name": "Monaco 2025",
      "description": "On va encore encore bien s'amuser",
    }
  ];


  @override
  Widget build(BuildContext context) {

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

             SizedBox(
               width: 250,
               child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child:  Text(
                  isToggled ? 'Vacances publiées par les utilisateurs' : 'Mes vacances',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.visible,
                  ),
                ),
            ),
             ),

            Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: ElevatedButton.icon(
                style: ButtonStyle(
                  padding: const MaterialStatePropertyAll(EdgeInsets.only(left: 10, right: 10)),
                  backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (states.contains(MaterialState.pressed)) {
                        return const Color(0xFF1E3A8A);
                      }
                      return const Color(0xFF1E3A8A);
                    },
                  ),
                ),
                icon: const Icon(Icons.add),
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

        Row(
          children: [
            Switch(
              value: isToggled,
              onChanged: (value) {
                setState(() {
                  isToggled = value;
                });
              },
              activeColor: const Color(0xFF1E3A8A),
            ),

            const Text('Vacances publiées par les utilisateurs'),
          ],
        ),


        Expanded(
          child: ListView.builder(
            itemCount: holidaysList.length,
            itemBuilder: (context, index) {
              final holiday = holidaysList[index];
              final name = holiday['name'];
              final description = holiday['description'];

              return HolidayCard(
                name: name!,
                description: description!,
              );

            },
          ),
        ),
      ],
    );
  }
}