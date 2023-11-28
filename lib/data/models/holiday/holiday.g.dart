// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'holiday.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Holiday _$HolidayFromJson(Map<String, dynamic> json) => Holiday(
      id: json['id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      creatorId: json['creatorId'] as String,
      participants: (json['participants'] as List<dynamic>)
          .map((e) => Participant.fromJson(e as Map<String, dynamic>))
          .toList(),
      isPublish: json['isPublish'] as bool,
      activities: (json['activities'] as List<dynamic>)
          .map((e) => Activity.fromJson(e as Map<String, dynamic>))
          .toList(),
      holidayPath: json['holidayPath'] as String,
    );

Map<String, dynamic> _$HolidayToJson(Holiday instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'location': instance.location,
      'creatorId': instance.creatorId,
      'participants': instance.participants,
      'isPublish': instance.isPublish,
      'activities': instance.activities,
      'holidayPath': instance.holidayPath,
    };
