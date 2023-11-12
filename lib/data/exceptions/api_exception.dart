class ApiException implements  Exception {
  final String message;
  final dynamic error;

  ApiException(this.message, this.error);

  @override
  String toString() {
    return message;
  }
}