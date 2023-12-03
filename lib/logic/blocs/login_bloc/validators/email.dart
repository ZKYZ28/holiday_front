import 'package:formz/formz.dart';


enum EmailInputError { invalid, empty }

extension EmailInputErrorExtension on EmailInputError {
  String get message {
    switch (this) {
      case EmailInputError.empty:
        return "Vous ne pouvez pas avoir une adresse mail vide.";
      case EmailInputError.invalid:
        return "Merci de respecter le format : john.doe@gmail.com.";
      default:
        return "Erreur inconnue. Veuillez contacter un administrateur.";
    }
  }
}

class EmailInput extends FormzInput<String, EmailInputError> {
  const EmailInput.pure() : super.pure('');
  const EmailInput.dirty({String value = ''}) : super.dirty(value);

  static final _emailRegExp = RegExp(
    r'^[a-zA-Z\d.!#$%&’*+/=?^_`{|}~-çÇ]+@[a-zA-Z\d-]+(?:\.[a-zA-Z\d-]{2,})+$',
  );

  @override
  EmailInputError? validator(String value) {
    return value.isEmpty ? EmailInputError.empty : _emailRegExp.hasMatch(value) ? null : EmailInputError.invalid;
  }
}