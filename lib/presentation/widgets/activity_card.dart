import 'package:flutter/material.dart';
import 'package:holiday_mobile/data/models/activity/activity.dart';

class ActivityCard extends StatelessWidget {
  final Activity activity;


  const ActivityCard({
    Key? key,
    required this.activity,
  }) : super(key: key);


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
          shape: BoxShape.circle, // cerle en fond
          color: Color(0xFF1E3A8A),
        ),
        child: IconButton(
          onPressed: () {
            print('Add appuyé');
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
