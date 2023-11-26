import 'dart:io';

import 'package:holiday_mobile/data/providers/data/LocationData.dart';

class ActivityData {
  final String? activityId; // edit
  final bool deleteImage; //edit
  final String? initialPath; // edit
  final String name;
  final String description;
  final double price;
  final DateTime startDate;
  final DateTime endDate;
  final File? file;
  final LocationData locationData;
  final String holidayId;

  ActivityData({
    this.activityId,
    this.deleteImage = false,
    this.initialPath,
    required this.name,
    required this.description,
    required this.price,
    required this.startDate,
    required this.endDate,
    required this.file,
    required this.locationData,
    required this.holidayId
  });

}