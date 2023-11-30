import 'package:holiday_mobile/data/models/holiday/holiday.dart';
import 'package:holiday_mobile/data/models/participant/participant.dart';
import 'package:holiday_mobile/data/providers/participant_api_provider.dart';

class ParticipantApiRepository{
  final _participantProvider= ParticipantApiProvider();

  Future<void> leaveHoliday(String holidayId) {
    return _participantProvider.leaveHoliday(holidayId);
  }

  Future<List<Participant>> getAllParticipantNotYetInHoliday(String holidayId, bool isParticipated) {
    return _participantProvider.getAllParticipantNotYetInHoliday(holidayId, isParticipated);
  }

  Future<List<Participant>> getAllParticipantNotYetInActivity(String activityId) {
    return _participantProvider.getAllParticipantNotYetInActivity(activityId);
  }
}