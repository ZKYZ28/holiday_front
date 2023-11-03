import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:holiday_mobile/presentation/widgets/holiday_card.dart';
import 'package:auto_route/annotations.dart';

import '../../routes/app_router.gr.dart';

@RoutePage()
class HolidaysPage extends StatefulWidget {
  const HolidaysPage({Key? key}) : super(key: key);

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
    return Scaffold(
      appBar: AppBar(
        title: Text(isToggled ? 'Vacances publiées par les utilisateurs' : 'Mes vacances'),
        actions: [
          ElevatedButton.icon(
            icon: const Icon(Icons.add),
            label: const Text('Encoder'),
            onPressed: () {
              context.router.push(const EncodeHolidayRoute());
            },
          ),
        ],
      ),

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
      ),
    );
  }
}