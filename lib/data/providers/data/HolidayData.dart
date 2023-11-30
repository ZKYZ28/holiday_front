import 'dart:io';

import 'package:holiday_mobile/data/providers/data/LocationData.dart';

class HolidayData {
  final String? holidayId; // edit
  final bool deleteImage; //edit
  final String? initialPath; // edit
  final bool isPublish;
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final File? file;
  final LocationData locationData;
  final String creatorId;

  HolidayData({
    this.holidayId,
    this.deleteImage = false,
    this.initialPath,
    this.isPublish = false,
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.file,
    required this.locationData,
    required this.creatorId,
  });
}
