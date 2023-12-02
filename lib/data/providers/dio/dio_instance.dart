import 'package:dio/dio.dart';
import 'package:holiday_mobile/configuration.dart';
import 'package:holiday_mobile/data/providers/dio/TokenInterceptor.dart';

class DioService {
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
      baseUrl: baseUrl ?? Configuration().baseUrl,
      connectTimeout: const Duration(seconds: 7),
      receiveTimeout: const Duration(seconds: 7)
    ));
  }

  void setAuthorizationBearer(String? jwt) {
    if (jwt != null) {
      _dio.options.headers['Authorization'] = "Bearer $jwt";
    } else {
      _dio.options.headers.remove('Authorization');
    }
  }

   void setCallBackMethod(void Function() notAuthorizedCallback) {
    _dio.interceptors.add(TokenInterceptor(notAuthorizedCallback: notAuthorizedCallback));
  }

}