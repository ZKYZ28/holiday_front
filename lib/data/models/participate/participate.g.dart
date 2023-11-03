// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'participate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Participate _$ParticipateFromJson(Map<String, dynamic> json) => Participate(
      id: json['id'] as String?,
      activityId: json['activityId'] as String,
      activity: json['activity'] == null
          ? null
          : Activity.fromJson(json['activity'] as Map<String, dynamic>),
      participantId: json['participantId'] as String,
      participant: json['participant'] == null
          ? null
          : Participant.fromJson(json['participant'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ParticipateToJson(Participate instance) =>
    <String, dynamic>{
      'id': instance.id,
      'activityId': instance.activityId,
      'activity': instance.activity,
      'participantId': instance.participantId,
      'participant': instance.participant,
    };
