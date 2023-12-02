import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:holiday_mobile/configuration.dart';
import 'package:holiday_mobile/data/models/login/login.dart';
import 'package:holiday_mobile/data/repositories/authentification_api_repository.dart';
import 'package:holiday_mobile/logic/blocs/login_bloc/validators/password.dart';
import 'package:holiday_mobile/logic/blocs/login_bloc/validators/email.dart';
import 'package:meta/meta.dart';

import 'validators/email.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  // TODO : repositoryProvider (injection main) ????????
  final AuthRepository authRepository;

  LoginBloc(this.authRepository) : super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmit>(_onSubmitLogin);
    on<GoogleLoginSubmit>(_onGoogleSubmit);
  }

  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    final email = EmailInput.dirty(value: event.email);
    emit(
      state.copyWith(
          // status: Formz.validate([email, state.password]) ? FormzSubmissionStatus.success : FormzSubmissionStatus.failure,
          status: FormzSubmissionStatus.inProgress,
          email: email,
          errorMessage: email
              .error?.message // si tout est resepcté, la valeur équivaut null
          ),
    );
  }

  void _onPasswordChanged(
      LoginPasswordChanged event, Emitter<LoginState> emit) {
    final password = PasswordInput.dirty(value: event.password);
    emit(
      state.copyWith(
          status: FormzSubmissionStatus.inProgress,
          // status: Formz.validate([state.email, password]) ? FormzSubmissionStatus.success : FormzSubmissionStatus.failure,
          password: password,
          // errorMessage: password.isNotValid ? password.error.toString() : null
          errorMessage: password.error?.message),
    );
  }

  Future<void> _onSubmitLogin(
      LoginSubmit event, Emitter<LoginState> emit) async {
    // Réinitialiser l'état avant de valider les champs
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    // Normalement, les deux champs seront valides
    if (state.email.isValid && state.password.isValid) {
      try {
        // String token = await authRepository.logInRequest(Login(email: state.email.value, password: state.password.value));
        await authRepository.logInRequest(
            Login(email: state.email.value, password: state.password.value));
        emit(state.copyWith(status: FormzSubmissionStatus.success));
      } catch (e) {
        emit(state.copyWith(
            status: FormzSubmissionStatus.failure, errorMessage: e.toString()));
      }
    } else {
      emit(state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: "Les champs ne sont pas valides !"));
    }
  }

  void _onGoogleSubmit(
      GoogleLoginSubmit event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      GoogleSignIn googleSignIn = GoogleSignIn(
        scopes: <String>[
          'email',
          'profile',
          'https://www.googleapis.com/auth/contacts.readonly',
        ],
      );

      // Si jamais, ça authentifie directement l'utilisateur avec son compte google
      // sans lui laisser le choix
      if (await googleSignIn.isSignedIn()) {
        await googleSignIn.signOut();
      }

      GoogleSignInAccount? account = await googleSignIn.signIn();

      // Si l'utilisateur nie la pop-up (clique à côte pour l'enlever)
      if (account == null) return;

      // Récupérer les informations de l'authentfiication
      final GoogleSignInAuthentication googleAuth =
          await account.authentication;
      String tokenId = googleAuth.idToken ?? Configuration.googleInvalidKey;

      // Récupérer le tokenId pour le transmettre à l'api afin de renvoyer le JWT
      if (tokenId == Configuration.googleInvalidKey) {
        emit(state.copyWith(
            status: FormzSubmissionStatus.failure,
            errorMessage:
                "Il a été impossible de vous authentifier avec Google. Merci de réessayer plus tard"));
        return;
      }

      // Call API
      await authRepository.logInGoogle(tokenId);
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } catch (e) {
      emit(state.copyWith(
          status: FormzSubmissionStatus.failure, errorMessage: e.toString()));
    }
  }
}
