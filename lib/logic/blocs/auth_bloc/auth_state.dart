part of 'auth_bloc.dart';

enum AuthStatus { unknow, authentificated, disconnected }

class AuthState extends Equatable {

  final AuthStatus status;

  const AuthState({
    this.status = AuthStatus.unknow
  });

  AuthState copyWith({
    AuthStatus? status,
  }) {
      return AuthState(
        status : status ?? this.status,
      );
  }


  @override
  List<Object?> get props => [status];

}
