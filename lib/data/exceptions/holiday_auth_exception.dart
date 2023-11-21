class HolidayAuthException implements Exception {
  final String message;
  HolidayAuthException(this.message);

  @override
  String toString() => "HolidayAuthException: $message";
}