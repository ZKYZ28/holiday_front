import 'package:holiday_mobile/data/models/Participant.dart';
import 'package:holiday_mobile/data/models/holiday/holiday.dart';
import 'package:json_annotation/json_annotation.dart';

part 'invitation.g.dart';

@JsonSerializable()
class Invitation {
  final String? id;
  final String holidayId;
  final Holiday? holiday;
  final String participantId;
  final Participant? participant;

  Invitation({
    this.id,
    required this.holidayId,
    this.holiday,
    required this.participantId,
    this.participant,
  });

  factory Invitation.fromJson(Map<String, dynamic> json) => _$InvitationFromJson(json);
  Map<String, dynamic> toJson() => _$InvitationToJson(this);
}