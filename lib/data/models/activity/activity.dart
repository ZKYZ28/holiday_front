import 'package:holiday_mobile/data/models/location/location.dart';

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
