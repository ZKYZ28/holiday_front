import 'dart:io';

import 'package:holiday_mobile/data/models/Participant.dart';
import 'package:holiday_mobile/data/models/activity/activity.dart';
import 'package:holiday_mobile/data/models/location/location.dart';

class Holiday {
  final String id;
  final String name;
  final String description;
  final String startDate;
  final String endDate;
  final Location location;
  final Participant participant;
  final bool isPublish;
  final List<Activity> activities;
  final String holidayPath;

  Holiday({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.participant,
    required this.isPublish,
    required this.activities,
    required this.holidayPath,
  });
}
