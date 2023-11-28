// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Location _$LocationFromJson(Map<String, dynamic> json) => Location(
      id: json['id'] as String?,
      number: json['number'] as String?,
      street: json['street'] as String?,
      locality: json['locality'] as String,
      postalCode: json['postalCode'] as String,
      country: json['country'] as String,
    );

Map<String, dynamic> _$LocationToJson(Location instance) => <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'street': instance.street,
      'locality': instance.locality,
      'postalCode': instance.postalCode,
      'country': instance.country,
    };
