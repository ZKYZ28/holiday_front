// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Register _$RegisterFromJson(Map<String, dynamic> json) => Register(
      email: json['email'] as String,
      lastName: json['lastName'] as String,
      firstName: json['firstName'] as String,
      password: json['password'] as String,
      confirmPassword: json['confirmPassword'] as String,
    );

Map<String, dynamic> _$RegisterToJson(Register instance) => <String, dynamic>{
      'email': instance.email,
      'lastName': instance.lastName,
      'firstName': instance.firstName,
      'password': instance.password,
      'confirmPassword': instance.confirmPassword,
    };
