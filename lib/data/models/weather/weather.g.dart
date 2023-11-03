// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Weather _$WeatherFromJson(Map<String, dynamic> json) => Weather(
      currentDay:
          WeatherDay.fromJson(json['currentDay'] as Map<String, dynamic>),
      weatherDays: (json['weatherDays'] as List<dynamic>)
          .map((e) => WeatherDay.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$WeatherToJson(Weather instance) => <String, dynamic>{
      'currentDay': instance.currentDay,
      'weatherDays': instance.weatherDays,
    };
