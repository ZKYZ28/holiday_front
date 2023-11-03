import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart';

@JsonSerializable()
class Location {
  final String? id;
  final String number;
  final String street;
  final String locality;
  final String postalCode;
  final String country;

  Location({
    this.id,
    required this.number,
    required this.street,
    required this.locality,
    required this.postalCode,
    required this.country,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}