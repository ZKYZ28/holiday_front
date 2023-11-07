import 'package:formz/formz.dart';


enum EmailInputError { invalid, empty }


class EmailInput extends FormzInput<String, EmailInputError> {
  const EmailInput.pure() : super.pure('');
  const EmailInput.dirty({String value = ''}) : super.dirty(value);

  static final _emailRegExp = RegExp(
    r'^[a-zA-Z\d.!#$%&’*+/=?^_`{|}~-çÇ]+@[a-zA-Z\d-]+(?:\.[a-zA-Z\d-]+)*$',
  );

  @override
  EmailInputError? validator(String value) {
    return value.isEmpty ? EmailInputError.empty : _emailRegExp.hasMatch(value) ? null : EmailInputError.invalid;
  }
}