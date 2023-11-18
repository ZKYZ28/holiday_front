import 'package:holiday_mobile/data/models/holiday/holiday.dart';
import 'package:holiday_mobile/data/models/participant/participant.dart';
import 'package:holiday_mobile/data/providers/participant_api_provider.dart';

class ParticipantApiRepository{
  final _participantProvider= ParticipantApiProvider();

  Future<void> leaveHoliday(String participantId, Holiday holiday) {
    return _participantProvider.leaveHoliday(participantId, holiday);
  }

  Future<List<Participant>> getAllParticipantNotYetInHoliday(String holidayId) {
    return _participantProvider.getAllParticipantNotYetInHoliday(holidayId);
  }

  Future<List<Participant>> getAllParticipantNotYetInActivity(String activityId) {
    return _participantProvider.getAllParticipantNotYetInActivity(activityId);
  }
}