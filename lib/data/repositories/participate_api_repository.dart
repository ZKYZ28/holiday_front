import 'package:holiday_mobile/data/models/participate/participate.dart';
import '../providers/participate_api_provider.dart';
import 'package:holiday_mobile/data/models/participant/participant.dart';

class ParticipateApiRepository{
  final _participateProvider= ParticipateApiProvider();

  Future<List<Participate>> getAllParticipatesByActivity(String activityId) {
    return _participateProvider.getAllParticipatesByActivity(activityId);
  }

  Future<void> createParticipates(List<Participant> participants, String activityId) {
    return _participateProvider.createParticipates(participants, activityId);
  }

  Future<void> deleteParticipate(Participate participate) {
    return _participateProvider.deleteParticipate(participate);
  }

}