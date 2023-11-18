import 'package:json_annotation/json_annotation.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

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


  String getFormattedAddress() {
    return '$street $number, $locality';
  }

  static Future<List<geocoding.Location>> locationsFromAddress(String address) async {
    try {
      print(address);
      List<geocoding.Location> geocodedLocations = await geocoding.locationFromAddress(address);

      return geocodedLocations;
    } catch (e) {
      return [];
    }
  }
}