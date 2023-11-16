part of 'auth_bloc.dart';


abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthentificationStatusChanged extends AuthEvent {
  final AuthStatus status;

  const AuthentificationStatusChanged({required this.status});

  @override
  List<Object> get props => [status];
}

class AuthentificationLogoutRequest extends AuthEvent {
  const AuthentificationLogoutRequest();
}
