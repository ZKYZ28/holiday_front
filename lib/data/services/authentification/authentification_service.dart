import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:holiday_mobile/data/exceptions/api_exception.dart';
import 'package:holiday_mobile/data/secure_storage/secure_storage.dart';

import '../../models/user_authentificated/user_authentificated.dart';

/**
 * Classe qui va effectuer la logique en collaboration
 * avec le AuthentificationProvider pour la gestion du login/register.
 */
class AuthService {

  final SecureStorage _secureStorage = SecureStorage();

  UserAuthentificated? decodeJwt(String jwtFromApi) {
    try {
      final jwt = JWT.decode(jwtFromApi);
      return UserAuthentificated(id: jwt.payload['nameid'], firstName: jwt.payload['given_name'], lastName: jwt.payload['family_name'], email: jwt.payload['email'], exp: jwt.payload['exp']);
    //  print('Payload ${jwt.payload}');
    } on JWTUndefinedException catch (e) {
      throw ApiException("Impossible de décoder le JWT", null);
    };
  }

  bool isTokenExpired(int exp) {
    DateTime expirationDateJwt = DateTime.fromMicrosecondsSinceEpoch(exp * 1000);
    return DateTime.now().isAfter(expirationDateJwt);
  }

  SecureStorage get secureStorage => _secureStorage;




}