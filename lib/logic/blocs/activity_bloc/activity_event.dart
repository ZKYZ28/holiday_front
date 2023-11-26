part of 'activity_bloc.dart';

abstract class ActivityEvent extends Equatable{
  const ActivityEvent();

  @override
  List<Object> get props => [];
}


class GetActivity extends ActivityEvent {
  final String activityId;

  const GetActivity({required this.activityId});

  @override
  List<Object> get props => [activityId];
}

class DeleteActivity extends ActivityEvent {
  final String activityId;

  const DeleteActivity({required this.activityId});

  @override
  List<Object> get props => [activityId];
}
