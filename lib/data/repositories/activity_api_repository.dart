import 'package:holiday_mobile/data/models/activity/activity.dart';
import 'package:holiday_mobile/data/providers/activity_api_provider.dart';
import 'package:holiday_mobile/data/providers/data/ActivityData.dart';

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
}