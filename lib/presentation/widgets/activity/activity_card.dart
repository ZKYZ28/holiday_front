import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:holiday_mobile/data/models/activity/activity.dart';
import 'package:holiday_mobile/routes/app_router.gr.dart';

import '../../../logic/blocs/holiday_bloc/holiday_bloc.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;
  final String holidayId;

  const ActivityCard({
    super.key,
    required this.activity,
    required this.holidayId
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
          ),

      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
        Text(
        activity.startDate,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
      ),
          Text('${activity.price} €'),
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
            context.read<HolidayBloc>().add(WaitingActivityAction());
            context.router.push(ActivityRoute(activityId: activity.id!, holidayId: holidayId));
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
