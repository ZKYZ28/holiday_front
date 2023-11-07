import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:holiday_mobile/logic/blocs/login_bloc/validators/password.dart';
import 'package:meta/meta.dart';

import 'validators/email.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged());
  }


  void _onEmailChanged(LoginEmailChanged event, Emitter<LoginState> emit) {
    final email = EmailInput.dirty(value : event.email);
    emit(
      state.copyWith(
        status: Formz.validate([state.email, password]) ? FormzSubmissionStatus. : FormzSubmissionStatus.
      ),
    )
  }

}
