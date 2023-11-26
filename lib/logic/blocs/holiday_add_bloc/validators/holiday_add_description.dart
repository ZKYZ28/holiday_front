import 'package:formz/formz.dart';

enum DescriptionHolidayInputError { invalid }

extension DescriptionHolidayInputErrorExtension on DescriptionHolidayInputError {
  String get message {
    switch (this) {
      case DescriptionHolidayInputError.invalid:
        return "Le description peut contenir de 0 et 500 caractères et peut inclure des lettres, des chiffres, des apostrophes, des tirets et des espaces et certains caractères spéciaux.";
      default:
        return "Erreur inconnue. Veuillez contacter un administrateur";
    }
  }
}

class DescriptionHolidayInput extends FormzInput<String, DescriptionHolidayInputError> {
  const DescriptionHolidayInput.pure() : super.pure('');
  const DescriptionHolidayInput.dirty({String value = ''}) : super.dirty(value);

  static final holidayNameRegExp = RegExp(
      r'''^[A-Za-z\dÀ-ÿ\s,.!?;:\"\(\)\-\+\&\'@\[\]\#\{\}\~\$\%\ù\çÇ\=\*]{0,500}$'''
  );


  @override
  DescriptionHolidayInputError? validator(String value) {
    return value.isEmpty ? null : holidayNameRegExp.hasMatch(value) ? null : DescriptionHolidayInputError.invalid;
  }
}