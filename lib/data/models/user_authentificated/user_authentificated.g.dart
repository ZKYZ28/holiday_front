// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_authentificated.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAuthentificated _$UserAuthentificatedFromJson(Map<String, dynamic> json) =>
    UserAuthentificated(
      id: json['id'] as String,
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      email: json['email'] as String,
      exp: json['exp'] as num,
    );

Map<String, dynamic> _$UserAuthentificatedToJson(
        UserAuthentificated instance) =>
    <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'exp': instance.exp,
    };

GoogleAuth _$GoogleAuthFromJson(Map<String, dynamic> json) => GoogleAuth(
      tokenId: json['tokenId'] as String,
    );

Map<String, dynamic> _$GoogleAuthToJson(GoogleAuth instance) =>
    <String, dynamic>{
      'tokenId': instance.tokenId,
    };
