import 'package:holiday_mobile/data/models/Participant.dart';
import 'package:holiday_mobile/data/models/holiday.dart';

class Invitation {
  final String id;
  final String holidayId;
  final Holiday holiday;
  final String participantId;
  final Participant participant;

  Invitation({
    required this.id,
    required this.holidayId,
    required this.holiday,
    required this.participantId,
    required this.participant,
  });
}

class InvitationMutation {
  final String holidayId;
  final String participantId;

  InvitationMutation({
    required this.holidayId,
    required this.participantId,
  });
}