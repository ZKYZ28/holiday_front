class Location {
  final String id;
  final String number;
  final String street;
  final String locality;
  final String postalCode;
  final String country;

  Location({
    required this.id,
    required this.number,
    required this.street,
    required this.locality,
    required this.postalCode,
    required this.country,
  });
}



class LocationSendFormActivity {
  final String? number;
  final String? street;
  final String? locality;
  final String? postalCode;
  final String? country;

  LocationSendFormActivity({
    this.number,
    this.street,
    this.locality,
    this.postalCode,
    this.country,
  });
}


class LocationSendFormHoliday {
  final String? number;
  final String? street;
  final String locality;
  final String postalCode;
  final String country;

  LocationSendFormHoliday({
    this.number,
    this.street,
    required this.locality,
    required this.postalCode,
    required this.country,
  });
}


class LocationMutation {
  final String number;
  final String street;
  final String locality;
  final String postalCode;
  final String country;

  LocationMutation({
    required this.number,
    required this.street,
    required this.locality,
    required this.postalCode,
    required this.country,
  });
}