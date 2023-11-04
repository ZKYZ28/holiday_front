import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:holiday_mobile/presentation/screens/activity_page.dart';

import 'activity_card.dart';

class ActivityData {
  final String title;
  final double price;
  final String description;
  final int numberParticipants;
  final String date;

  ActivityData({
  required this.title,
  required this.description,
  required this.date,
  required this.price,
  required this.numberParticipants});
}

class ActivityContainer extends StatelessWidget {
  final List<ActivityData> activities;
  final double activityHeight;

  const ActivityContainer(
      {super.key,
        required this.activities,
        required this.activityHeight,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxHeight: activityHeight),
      child: Card(
        elevation: 5,
        child: Column(
          children: [
            // Header
            Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Activité(s) prévue(s)',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF1E3A8A)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, // cerle en fond
                          color: Color(0xFF1E3A8A),
                        ),
                        child: IconButton(
                          onPressed: () {
                            print('Add appuyé');
                          },
                          icon: Icon(
                            Icons.calendar_month,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle, // cerle en fond
                          color: Color(0xFF1E3A8A),
                        ),
                        child: IconButton(
                          onPressed: () {
                            print('Add appuyé');
                          },
                          icon: Icon(
                            Icons.add,
                            size: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
            // Permet de faire une ligne séparatrice
            Divider(
              color: Colors.grey,
              thickness: 1, // Épaisseur de la ligne
            ),

            // Liste des activités

              Expanded(
                child : ListView.builder(
                  itemCount: activities.length,
                  itemBuilder: (context, index) {
                    final activity = activities[index];
                    return ActivityCard(
                        title: activity.title,
                        date: activity.date,
                        price: activity.price,
                        imageUrl : 'assets/images/bgHoliday.jpg');
                  }),
            )


          ],
        ),
      ),
    );
  }
}
