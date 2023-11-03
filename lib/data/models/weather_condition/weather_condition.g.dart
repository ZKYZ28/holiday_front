// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_condition.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherCondition _$WeatherConditionFromJson(Map<String, dynamic> json) =>
    WeatherCondition(
      description: json['description'] as String,
      iconPath: json['iconPath'] as String,
    );

Map<String, dynamic> _$WeatherConditionToJson(WeatherCondition instance) =>
    <String, dynamic>{
      'description': instance.description,
      'iconPath': instance.iconPath,
    };
