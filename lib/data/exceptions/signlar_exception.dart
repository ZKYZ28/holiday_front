class SignalRException implements  Exception {
  final String message;
  final dynamic error;

  SignalRException(this.message, this.error);

  @override
  String toString() {
    return message;
  }
}