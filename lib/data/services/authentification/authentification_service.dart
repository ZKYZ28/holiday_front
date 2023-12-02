import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:holiday_mobile/data/exceptions/api_exception.dart';
import 'package:holiday_mobile/data/exceptions/holiday_auth_exception.dart';
import 'package:holiday_mobile/data/exceptions/holiday_storage_exception.dart';
import 'package:holiday_mobile/data/secure_storage/secure_storage.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

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
      return UserAuthentificated(id: jwt.payload['nameid'], firstName: jwt.payload['given_name'], lastName: jwt.payload['family_name'], email: jwt.payload['email']);
    } on JWTUndefinedException catch (e) {
      throw HolidayAuthException("Impossible de décoder le JWT");
    };
  }

  int decodeJwtExp(String jwtFromApi) {
    try {
      final jwt = JWT.decode(jwtFromApi);
      return jwt.payload['exp'];
    } on JWTUndefinedException catch (e) {
      throw HolidayAuthException("Impossible de décoder le JWT");
    };
  }

  bool isTokenExpired(int exp) {
    var parisTimeZone = tz.getLocation('Europe/Paris');
    DateTime expirationDateJwt = tz.TZDateTime.fromMillisecondsSinceEpoch(parisTimeZone, exp * 1000);

    return tz.TZDateTime.now(parisTimeZone).isAfter(expirationDateJwt);
  }

  SecureStorage get secureStorage => _secureStorage;




}