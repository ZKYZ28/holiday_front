class LocationData {
  final String? locationId; // edit
  final String country;
  final String locality;
  final String street;
  final String postalCode;
  final String numberBox;

  LocationData({
    this.locationId,
    required this.country,
    required this.locality,
    required this.street,
    required this.postalCode,
    required this.numberBox,
  });
}