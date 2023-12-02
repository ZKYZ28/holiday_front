import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:holiday_mobile/data/providers/authentification_api_provider.dart';
import 'package:holiday_mobile/data/providers/dio/dio_instance.dart';
import 'package:holiday_mobile/data/repositories/authentification_api_repository.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {

  final AuthRepository _repository;
  late StreamSubscription _authStatusSubscription;

  // On s'assure d'avoir le repository avant
  AuthBloc({required AuthRepository repository}) : _repository = repository, super(const AuthState()) {

    // Ecouter les changements d'états émis par le repository qui fait les appels
    _authStatusSubscription = _repository.authStatusStream.listen((AuthStatus status) {
      add(AuthentificationStatusChanged(status: status));
    });

    on<AuthentificationStatusChanged>(_onAuthentificationStatusChanged);
    on<AuthentificationLogoutRequest>(_onAuthentficationStatusLogout);
  }

  void _onAuthentificationStatusChanged(AuthentificationStatusChanged event, Emitter<AuthState> emit) {
    if (event.status == AuthStatus.authentificated) {
       emit(state.copyWith(status: AuthStatus.authentificated));
    }

    if (event.status == AuthStatus.disconnected) {
       emit(state.copyWith(status: AuthStatus.disconnected));
    }
  }

  Future<void> _onAuthentficationStatusLogout(AuthentificationLogoutRequest event, Emitter<AuthState> emit) async {
    await _repository.logOut();
  }

  @override
  Future<void> close() {
    _authStatusSubscription.cancel();
    return super.close();
  }
}
