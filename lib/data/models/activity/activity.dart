import 'package:holiday_mobile/data/models/location/location.dart';
import 'package:json_annotation/json_annotation.dart';

part 'activity.g.dart';

@JsonSerializable()
class Activity {
  final String? id;
  final String name;
  final String? description;
  final double price;
  final String startDate;
  final String endDate;
  final Location location;
  final String activityPath;
  final String holidayId;

  Activity({
    this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.activityPath,
    required this.holidayId,
  });

  factory Activity.fromJson(Map<String, dynamic> json) => _$ActivityFromJson(json);
  Map<String, dynamic> toJson() => _$ActivityToJson(this);
}
