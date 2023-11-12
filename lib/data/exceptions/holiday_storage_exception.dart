class HolidayStorageException implements Exception {
  final String message;
  HolidayStorageException(this.message);

  @override
  String toString() => "HolidayStorageException: $message";
}
