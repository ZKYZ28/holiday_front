// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_day.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherDay _$WeatherDayFromJson(Map<String, dynamic> json) => WeatherDay(
      date: json['date'] as String,
      maxTemp: json['maxTemp'] as num,
      minTemp: json['minTemp'] as num,
      currentTemp: json['currentTemp'] as num,
      riskOfRain: json['riskOfRain'] as num,
      riskOfSnow: json['riskOfSnow'] as num,
      condition:
          WeatherCondition.fromJson(json['condition'] as Map<String, dynamic>),
      weatherByHour: (json['weatherByHour'] as List<dynamic>)
          .map((e) => WeatherHour.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WeatherDayToJson(WeatherDay instance) =>
    <String, dynamic>{
      'date': instance.date,
      'maxTemp': instance.maxTemp,
      'minTemp': instance.minTemp,
      'currentTemp': instance.currentTemp,
      'riskOfRain': instance.riskOfRain,
      'riskOfSnow': instance.riskOfSnow,
      'condition': instance.condition,
      'weatherByHour': instance.weatherByHour,
    };
