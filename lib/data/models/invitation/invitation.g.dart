// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'invitation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Invitation _$InvitationFromJson(Map<String, dynamic> json) => Invitation(
      id: json['id'] as String?,
      holidayId: json['holidayId'] as String,
      holiday: json['holiday'] == null
          ? null
          : Holiday.fromJson(json['holiday'] as Map<String, dynamic>),
      participantId: json['participantId'] as String,
      participant: json['participant'] == null
          ? null
          : Participant.fromJson(json['participant'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$InvitationToJson(Invitation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'holidayId': instance.holidayId,
      'holiday': instance.holiday,
      'participantId': instance.participantId,
      'participant': instance.participant,
    };
