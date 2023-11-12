import 'package:dio/dio.dart';

class DioService {
  // On appelle le constructeur privé
  static DioService? _instance;
  late final Dio _dio;

  // Un constructeur factory permet de créer une nouvelle instance d'une classe
  // ou retourner une instance existante -> parfait pour notre singleton
  factory DioService({String? baseUrl}) {
    return _instance ??= DioService._internal(baseUrl: baseUrl);
  }

  Dio get dio => _dio;

  // Constructeur privé
  DioService._internal({String? baseUrl}) {
    _dio = Dio(BaseOptions(
      baseUrl: baseUrl ?? 'https://10.0.2.2:7048/',
      connectTimeout: const Duration(seconds: 5),
      receiveTimeout: const Duration(seconds: 5)
      // TODO : ajouter les interceptor ici pour le JWT
    ));
  }

  void setAuthorizationBearer(String? jwt) {
    if (jwt != null) {
      _dio.options.headers['Authorization'] = "Bearer $jwt";
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }

}