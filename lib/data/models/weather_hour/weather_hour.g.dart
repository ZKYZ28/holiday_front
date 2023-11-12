// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_hour.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherHour _$WeatherHourFromJson(Map<String, dynamic> json) => WeatherHour(
      dateAndTime: json['dateAndTime'] as String,
      temp: json['temp'] as num,
      pathImage: json['pathImage'] as String,
    );

Map<String, dynamic> _$WeatherHourToJson(WeatherHour instance) =>
    <String, dynamic>{
      'dateAndTime': instance.dateAndTime,
      'temp': instance.temp,
      'pathImage': instance.pathImage,
    };
