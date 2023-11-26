import 'package:holiday_mobile/data/models/activity/activity.dart';
import 'package:holiday_mobile/data/providers/activity_api_provider.dart';

class ActivityApiRepository{
  final _activityProvider = ActivityApiProvider();

  Future<Activity> fetActivity(String activityId) {
    return _activityProvider.fetchActivityById(activityId);
  }

  Future<void> deleteActivity(String activity) {
    return _activityProvider.deleteActivity(activity);
  }
}