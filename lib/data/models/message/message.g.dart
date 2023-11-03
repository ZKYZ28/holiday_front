// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Message _$MessageFromJson(Map<String, dynamic> json) => Message(
      sendAt: json['sendAt'] as String,
      content: json['content'] as String,
      holiday: Holiday.fromJson(json['holiday'] as Map<String, dynamic>),
      holidayId: json['holidayId'] as String,
      participant:
          Participant.fromJson(json['participant'] as Map<String, dynamic>),
      participantId: json['participantId'] as String,
    );

Map<String, dynamic> _$MessageToJson(Message instance) => <String, dynamic>{
      'sendAt': instance.sendAt,
      'content': instance.content,
      'holiday': instance.holiday,
      'holidayId': instance.holidayId,
      'participant': instance.participant,
      'participantId': instance.participantId,
    };
