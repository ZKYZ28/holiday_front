import 'package:json_annotation/json_annotation.dart';

part 'user_authentificated.g.dart';

@JsonSerializable()
class UserAuthentificated {
  final String id;
  final String firstName;
  final String lastName;
  final String email;

  UserAuthentificated({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });


  factory UserAuthentificated.fromJson(Map<String, dynamic> json) => _$UserAuthentificatedFromJson(json);
  Map<String, dynamic> toJson() => _$UserAuthentificatedToJson(this);
}

@JsonSerializable()
class GoogleAuth {
  final String tokenId;

  GoogleAuth({
    required this.tokenId,
  });

  factory GoogleAuth.fromJson(Map<String, dynamic> json) => _$GoogleAuthFromJson(json);
  Map<String, dynamic> toJson() => _$GoogleAuthToJson(this);
}