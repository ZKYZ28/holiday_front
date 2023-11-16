import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:holiday_mobile/data/repositories/authentification_api_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AuthRepository _repository;
  late StreamSubscription _authStatusSubscription;

  // On s'assure d'avoir le repository avant
  AuthBloc({required AuthRepository repository}) : _repository = repository, super(const AuthState()) {
    on<AuthentificationStatusChanged>(_onAuthentificationStatusChanged);

   // _authStatusSubscription = _re

  }

  void _onAuthentificationStatusChanged(AuthentificationStatusChanged event, Emitter<AuthState> emit) {

    if (event.status == AuthStatus.authentificated) {
      return emit(state.copyWith(status: AuthStatus.authentificated));
    }

    if (event.status == AuthStatus.disconnected) {
      return emit(state.copyWith(status: AuthStatus.disconnected));
    }
  }
}
