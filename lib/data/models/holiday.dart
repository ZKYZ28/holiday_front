import 'dart:io';

import 'package:holiday_mobile/data/models/Participant.dart';
import 'package:holiday_mobile/data/models/activity.dart';
import 'package:holiday_mobile/data/models/location.dart';

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

class HolidaySendForm {
  final String name;
  final String? description;
  final String startDate;
  final String endDate;
  final LocationSendFormHoliday location;
  final File? uploadedHolidayPicture; //PEUT ETRE FILEIMAGE

  HolidaySendForm({
    required this.name,
    this.description,
    required this.startDate,
    required this.endDate,
    required this.location,
    this.uploadedHolidayPicture,
  });
}

class HolidayMutation {
  final String name;
  final String description;
  final String startDate;
  final String endDate;
  final LocationSendFormHoliday location;
  final bool isPublish;
  final List<Activity> activities;
  final String holidayPath;

  HolidayMutation({
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.isPublish,
    required this.activities,
    required this.holidayPath,
  });
}