import 'package:dio/dio.dart';

Dio createDioInstance() {
  final dio = Dio();

  // Configuration de Dio
  dio.options.baseUrl = 'https://localhost:7048/';
  dio.options.connectTimeout = const Duration(seconds: 5);
  dio.options.receiveTimeout = const Duration(seconds: 3);

  return dio;
}