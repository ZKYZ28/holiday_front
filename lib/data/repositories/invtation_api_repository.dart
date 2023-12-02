import 'package:holiday_mobile/data/models/invitation/invitation.dart';
import 'package:holiday_mobile/data/models/participant/participant.dart';
import 'package:holiday_mobile/data/providers/invitation_api_provider.dart';

class InvitationApiRepository{
  final _invitationProvider= InvitationsApiProvider();

  Future<void> createInvitations(List<Participant> participants, String holidayIdy) {
    return _invitationProvider.createInvitations(participants, holidayIdy);
  }

  Future<List<Invitation>> getAllInvitationsByParticipant() {
    return _invitationProvider.fetchAllInvitationsByParticipant();
  }

  Future<void> acceptInvitation(String invitationId) {
    return _invitationProvider.acceptInvitation(invitationId);
  }

  Future<void> refuseInvitation(String invitationId) {
    return _invitationProvider.refuseInvitation(invitationId);
  }
}