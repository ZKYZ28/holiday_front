import 'package:holiday_mobile/data/models/holiday/holiday.dart';
import 'package:json_annotation/json_annotation.dart';

import '../participant/participant.dart';

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

  static List<Invitation> createInvitations (List<Participant> participants, String holidayId){
    List<Invitation> invitations = [];

    for (var participant in participants) {
      var invitation = Invitation(
        holidayId: holidayId,
        participantId: participant.id!,
      );
      invitations.add(invitation);
    }

    return invitations;
  }

  static List<Map<String, dynamic>> invitationsToJsonList(List<Invitation> invitations) {
    List<Map<String, dynamic>> jsonList = [];
    for (var invitation in invitations) {
      jsonList.add(invitation.toJson());
    }
    return jsonList;
  }
}