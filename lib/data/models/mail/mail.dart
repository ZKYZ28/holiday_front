import 'package:json_annotation/json_annotation.dart';

part 'mail.g.dart';

@JsonSerializable()
class Mail {
  final String senderEmail;
  final String content;

  Mail({
    required this.senderEmail,
    required this.content,
  });


  factory Mail.fromJson(Map<String, dynamic> json) => _$MailFromJson(json);
  Map<String, dynamic> toJson() => _$MailToJson(this);
}