import 'dart:core';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:holiday_mobile/data/models/activity/activity.dart';
import 'package:holiday_mobile/routes/app_router.gr.dart';
import 'activity_card.dart';


class ActivityContainer extends StatelessWidget {
  final List<Activity> activities;
  final double activityHeight;
  final String holidayId;
  final Future<void> Function() afterEncodeOrEdit;
  final bool isPublish;

  const ActivityContainer(
      {super.key,
        required this.activities,
        required this.activityHeight,
        required this.holidayId,
        required this.afterEncodeOrEdit,
        required this.isPublish,
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
              margin: const EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Activité(s) prévue(s)',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Color(0xFF1E3A8A)),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const SizedBox(
                        width: 10,
                      ),

                      if(isPublish == false)
                      Container(
                        width: 35,
                        height: 35,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle, // cerle en fond
                          color: Color(0xFF1E3A8A),
                        ),
                        child: IconButton(
                          onPressed: () {
                            context.router.push(EncodeActivityRoute(holidayId: holidayId)).then((value) => afterEncodeOrEdit());
                          },
                          icon: const Icon(
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
            const Divider(
              color: Colors.grey,
              thickness: 1, // Épaisseur de la ligne
            ),

            // Liste des activités
              Expanded(
                child : ListView.builder(
                  itemCount: activities.length,
                  itemBuilder: (context, index) {
                    final activity = activities[index];
                    return ActivityCard(activity: activity, holidayId: holidayId, isPublish: isPublish);
                  }),
            )

          ],
        ),
      ),
    );
  }
}
