import 'package:holiday_mobile/data/models/activity/activity.dart';
import 'package:holiday_mobile/data/providers/activity_api_provider.dart';
import 'package:holiday_mobile/data/providers/data/ActivityData.dart';

import '../models/participant/participant.dart';

class ActivityApiRepository{
  final _activityProvider = ActivityApiProvider();

  Future<Activity> fetActivity(String activityId) {
    return _activityProvider.fetchActivityById(activityId);
  }

  Future<void> deleteActivity(String activity) {
    return _activityProvider.deleteActivity(activity);
  }

  Future<void> createActivity(ActivityData activityData) async {
    return await _activityProvider.createActivity(activityData);
  }

  Future<void> updateActivity(ActivityData activityData) async {
    return await _activityProvider.updateActivity(activityData);
  }

  Future<void> deleteParticipate(String activityId, String participantId) {
    return _activityProvider.deleteParticipate(activityId, participantId);
  }

  Future<List<Participant>> getAllParticipantByActivity(String activityId, bool isParticipated) {
    return _activityProvider.getParticipantsByActivity(activityId, isParticipated);
  }

  Future<void> createParticipate(String activityId , String participant) {
    return _activityProvider.createParticipate(activityId, participant);
  }
}