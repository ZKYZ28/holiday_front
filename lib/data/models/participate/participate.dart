import 'package:holiday_mobile/data/models/activity/activity.dart';
import 'package:json_annotation/json_annotation.dart';

import '../participant/participant.dart';

part 'participate.g.dart';

@JsonSerializable()
class Participate {
  final String? id;
  final String activityId;
  final Activity? activity;
  final String participantId;
  final Participant? participant;

  Participate({
    this.id,
    required this.activityId,
    this.activity,
    required this.participantId,
    this.participant,
  });


  factory Participate.fromJson(Map<String, dynamic> json) => _$ParticipateFromJson(json);
  Map<String, dynamic> toJson() => _$ParticipateToJson(this);
}