import 'package:holiday_mobile/data/models/login/login.dart';
import 'package:holiday_mobile/data/models/user_authentificated/user_authentificated.dart';
import 'package:holiday_mobile/data/providers/authentification_api_provider.dart';

class AuthRepository{

  final _authProvider = AuthAPiProvider();

  Future<void> logInRequest(Login login) {
    return _authProvider.logInSimple(login);
  }



}