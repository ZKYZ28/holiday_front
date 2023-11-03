import 'package:holiday_mobile/data/models/Participant.dart';
import 'package:holiday_mobile/data/models/activity/activity.dart';

class Participate {
  final String id;
  final String activityId;
  final Activity activity;
  final String participantId;
  final Participant participant;

  Participate({
    required this.id,
    required this.activityId,
    required this.activity,
    required this.participantId,
    required this.participant,
  });
}

class ParticipateListUser {
  final String activityId;
  final String participantId;

  ParticipateListUser({
    required this.activityId,
    required this.participantId,
  });
}