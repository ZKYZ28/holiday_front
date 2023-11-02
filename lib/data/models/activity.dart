import 'package:holiday_mobile/data/models/location.dart';

class Activity {
  final String id;
  final String name;
  final String description;
  final double price;
  final String startDate;
  final String endDate;
  final Location location;
  final String activityPath;
  final String holidayId;

  Activity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.activityPath,
    required this.holidayId,
  });
}

class ActivitySendForm {
  final String name;
  final String? description;
  final double? price;
  final String? startDate;
  final String? endDate;
  final LocationSendFormActivity? location;
  final String holidayId;

  ActivitySendForm({
    required this.name,
    this.description,
    this.price,
    this.startDate,
    this.endDate,
    this.location,
    required this.holidayId,
  });
}

class ActivityMutation {
  final String name;
  final String description;
  final double price;
  final String startDate;
  final String endDate;
  final LocationSendFormActivity location;
  final String activityPath;
  final String holidayId;

  ActivityMutation({
    required this.name,
    required this.description,
    required this.price,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.activityPath,
    required this.holidayId,
  });
}