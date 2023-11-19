import 'package:holiday_mobile/data/models/login/login.dart';
import 'package:holiday_mobile/data/models/user_authentificated/user_authentificated.dart';
import 'package:holiday_mobile/data/providers/authentification_api_provider.dart';
import 'package:holiday_mobile/logic/blocs/auth_bloc/auth_bloc.dart';

class AuthRepository{

  final AuthAPiProvider _authProvider;

  AuthRepository(this._authProvider);

  Stream<AuthStatus> get authStatusStream => _authProvider.authStatusStream;

  UserAuthentificated? get userConnected => _authProvider.userConnected;

  Future<void> logInRequest(Login login) {
    return _authProvider.logInSimple(login);
  }

  Future<void> logOut() async {
    return _authProvider.logOut();
  }

  Future<void> logInGoogle(String tokenId) {
    return _authProvider.logInGoogle(tokenId);
  }



}