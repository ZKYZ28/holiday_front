// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'mail.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Mail _$MailFromJson(Map<String, dynamic> json) => Mail(
      senderEmail: json['senderEmail'] as String,
      content: json['content'] as String,
    );

Map<String, dynamic> _$MailToJson(Mail instance) => <String, dynamic>{
      'senderEmail': instance.senderEmail,
      'content': instance.content,
    };
