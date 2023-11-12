part of 'login_bloc.dart';


class LoginState extends Equatable {

  final FormzSubmissionStatus status;
  final EmailInput email;
  final PasswordInput password;
  final String? errorMessage;

  // Valeurs initiales à la création
  const LoginState({
    this.status = FormzSubmissionStatus.initial,
    this.email = const EmailInput.pure(),
    this.password = const PasswordInput.pure(),
    this.errorMessage = ""
  });

  // Copier en conservant les anciennes valeurs non spécifiées en paramètres
  LoginState copyWith({
    FormzSubmissionStatus? status,
    EmailInput? email,
    PasswordInput? password,
    String? errorMessage
  }) {
    return LoginState(
      status : status ?? this.status,
      email: email ?? this.email,
      password : password ?? this.password,
      errorMessage : errorMessage ?? this.errorMessage
    );
  }

  @override
  List<Object> get props => [status, email, password, errorMessage ?? ""];
}
