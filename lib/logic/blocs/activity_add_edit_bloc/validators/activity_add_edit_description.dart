import 'package:formz/formz.dart';
enum ActivityDescriptionInputError { invalid }

extension ActivityDescriptionInputErrorExtension on ActivityDescriptionInputError {
  String get message {
    switch (this) {
      case ActivityDescriptionInputError.invalid:
        return "La description peut contenir de 0 et 500 caractères et peut inclure des lettres, des chiffres, des apostrophes, des tirets et des espaces et certains caractères spéciaux.";
      default:
        return "Erreur inconnue. Veuillez contacter un administrateur";
    }
  }
}

class ActivityDescriptionInput extends FormzInput<String, ActivityDescriptionInputError> {
  const ActivityDescriptionInput.pure() : super.pure('');
  const ActivityDescriptionInput.dirty({String value = ''}) : super.dirty(value);

  static final activityDescriptionRegExp = RegExp(
      r'''^[A-Za-z\dÀ-ÿ\s,.!?;:\"\(\)<>\-\+\&\'@\[\]\#\{\}\~\$\%\ù\çÇ\=\*]{0,500}$'''
  );


  @override
  ActivityDescriptionInputError? validator(String value) {
    return value.isEmpty ? null : activityDescriptionRegExp.hasMatch(value) ? null : ActivityDescriptionInputError.invalid;
  }
}