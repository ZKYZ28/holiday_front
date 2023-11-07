import 'package:formz/formz.dart';

enum PasswordInputError { tooShort, noDigit, noUppercase, noLowerCase, noSpecialChars}


class PasswordInput extends FormzInput<String, PasswordInputError> {
  const PasswordInput.pure() : super.pure('');
  const PasswordInput.dirty({String value = ''}) : super.dirty(value);

  static final _emailRegExp = RegExp(
    r'^[a-zA-Z\d.!#$%&’*+/=?^_`{|}~-çÇ]+@[a-zA-Z\d-]+(?:\.[a-zA-Z\d-]+)*$',
  );

  @override
  PasswordInputError? validator(String value) {
    if(value.length < 8) return PasswordInputError.tooShort;
    if (!value.contains(RegExp(r'\d'))) return PasswordInputError.noDigit;
    if (!value.contains(RegExp(r'[A-Z]'))) return PasswordInputError.noUppercase;
    if (!value.contains(RegExp(r'[a-]'))) return PasswordInputError.noDigit;
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|=+;<>/\\~_-]'))) return PasswordInputError.noSpecialChars;
    return null;
  }
}