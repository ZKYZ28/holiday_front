import 'package:dio/dio.dart';
import 'package:holiday_mobile/data/services/authentification/authentification_service.dart';
import '../../exceptions/api_exception.dart';

class TokenInterceptor extends Interceptor {
  final Function notAuthorizedCallback;
  int? tokenExpiration;
  String? lastToken;

  // TODO : passer en paramètre ?
  final AuthService _authService = AuthService();

  TokenInterceptor({required this.notAuthorizedCallback});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.headers.containsKey('Authorization')) {
      final currentToken = options.headers['Authorization']!.split(" ").last;

      if (lastToken == null || lastToken != currentToken) {
        // Le JWT a changé, soit car il est nouveau ou car l'utiliateur s'est reconnecté
        lastToken = currentToken;
        try {
          tokenExpiration = _authService.decodeJwtExp(lastToken!);
        } on ApiException catch (e) {
          throw ApiException(e.message, null);
        }
      }

      if (tokenExpiration != null &&
          _authService.isTokenExpired(tokenExpiration!)) {
        notAuthorizedCallback(); // Fonction pour déconnecter l'utilisateur
      }
    }
    handler.next(
        options); // Continuer de transmettre la requête bien qu'on ait effectué un traiment dessus ou non

  }
}
