import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/models/activity/activity.dart';
import 'package:holiday_mobile/logic/blocs/activity_bloc/activity_bloc.dart';
import 'package:holiday_mobile/main.dart';
import 'package:holiday_mobile/routes/app_router.gr.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart';

import '../../../logic/blocs/holiday_bloc/holiday_bloc.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;
  final String holidayId;
  final bool isPublish;

  const ActivityCard({
    super.key,
    required this.activity,
    required this.holidayId,
    required this.isPublish,
  });


  @override
  Widget build(BuildContext context) {

    return Card(
      color: Colors.grey[100],
      child :ListTile(
      leading: Image.network('https://10.0.2.2:7048/${activity.activityPath}'),
      title:
          Text(
            activity.name,
            style: const TextStyle(
              fontSize: 22,
              color: Color(0xFF1E3A8A),
              fontWeight: FontWeight.bold,
            ),
            overflow: TextOverflow.ellipsis,
          ),

      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
        Text(
          // TODO : champ activity date nullable, alors faire cette vérif :
          activity.startDate != null ? DateFormat('dd/MM/yyyy HH:mm').format(TZDateTime.parse(globalLocation!, activity.startDate)) : "Non défini",
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
      ),
          Text('${activity.price.toStringAsFixed(2)} €'),
        ],
      ),
      trailing: Container(
        width: 35,
        height: 35,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xFF1E3A8A),
        ),
        child: IconButton(
          onPressed: () {
            context.router.push(ActivityRoute(activityId: activity.id!, holidayId: holidayId, isPublish: isPublish));
          },
          icon: const Icon(
            Icons.remove_red_eye,
            size: 20,
            color: Colors.white,
          ),
        ),
      ),
    ),
    );
  }
}
