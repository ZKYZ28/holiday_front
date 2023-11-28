// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Activity _$ActivityFromJson(Map<String, dynamic> json) => Activity(
      id: json['id'] as String?,
      name: json['name'] as String,
      description: json['description'] as String?,
      price: (json['price'] as num).toDouble(),
      startDate: json['startDate'] as String,
      endDate: json['endDate'] as String,
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      activityPath: json['activityPath'] as String,
      holidayId: json['holidayId'] as String,
    );

Map<String, dynamic> _$ActivityToJson(Activity instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'price': instance.price,
      'startDate': instance.startDate,
      'endDate': instance.endDate,
      'location': instance.location,
      'activityPath': instance.activityPath,
      'holidayId': instance.holidayId,
    };
