import 'package:holiday_mobile/data/models/Participant.dart';
import 'package:holiday_mobile/data/models/holiday.dart';

class Message {
  final String sendAt;
  final String content;
  final Holiday holiday;
  final String holidayId;
  final Participant participant;
  final String participantId;

  Message({
    required this.sendAt,
    required this.content,
    required this.holiday,
    required this.holidayId,
    required this.participant,
    required this.participantId,
  });
}