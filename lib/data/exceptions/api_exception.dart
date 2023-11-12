class ApiException implements  Exception {
  final String message;
  final dynamic error;

  ApiException(this.message, this.error);

  /*factory ApiException.fromJson(dynamic responseData) {
    if (responseData is Map<String, dynamic> && responseData.containsKey('message')) {
      final message = responseData['message'] as String;
      return ApiException(message, responseData);
    } else {
      return ApiException('Désolé, il s\'emblerait que une erreur est survenue.', responseData);
    }
  }*/

  @override
  String toString() {
    return message;
  }
}