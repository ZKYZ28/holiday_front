import 'package:formz/formz.dart';

enum PasswordInputError { tooShort, noDigit, noUppercase, noLowerCase, noSpecialChars}

extension PasswordInputErrorExtension on PasswordInputError {
  String get message {
    switch (this) {
      case PasswordInputError.tooShort:
        return "Le mot de passe doit faire au minimum 8 caracètres.";
      case PasswordInputError.noDigit:
        return "Le mot de passe doit au moins contenir un nombre.";
      case PasswordInputError.noUppercase:
        return "Le mot de passe doit au moins contenir une majuscule.";
      case PasswordInputError.noLowerCase:
        return "Le mot de passe doit au moins contenir une minuscule.";
      case PasswordInputError.noSpecialChars:
        return "Le mot de passe doit au moins contenir un caractère spécial.";
      default:
        return "Erreur inconnue.";
    }
  }
}

class PasswordInput extends FormzInput<String, PasswordInputError> {
  const PasswordInput.pure() : super.pure('');
  const PasswordInput.dirty({String value = ''}) : super.dirty(value);

  @override
  PasswordInputError? validator(String value) {
    if(value.length < 8) return PasswordInputError.tooShort;
    if (!value.contains(RegExp(r'\d'))) return PasswordInputError.noDigit;
    if (!value.contains(RegExp(r'[A-Z]'))) return PasswordInputError.noUppercase;
    if (!value.contains(RegExp(r'[a-z]'))) return PasswordInputError.noDigit;
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|=+;<>/\\~_-çÇ]'))) return PasswordInputError.noSpecialChars;
    return null;
  }
}