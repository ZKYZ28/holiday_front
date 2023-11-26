import 'package:formz/formz.dart';

enum ActivityPriceInputError { invalid }

extension ActivityPriceInputErrorExtension on ActivityPriceInputError {
  String get message {
    switch (this) {
      case ActivityPriceInputError.invalid:
        return "Champ facultatif. Si vous choisissez de le remplir, veuillez saisir un nombre avec au maximum deux chiffres après le point en tant que séparateur décimal.";
      default:
        return "Erreur inconnue. Veuillez contacter un administrateur";
    }
  }
}

class ActivityPriceInput extends FormzInput<String, ActivityPriceInputError> {
  const ActivityPriceInput.pure() : super.pure('');
  const ActivityPriceInput.dirty({String value = ''}) : super.dirty(value);

  static final ActivityPriceRegExp = RegExp(
    r"^\d+(\.\d{1,2})?$",
  );

  @override
  ActivityPriceInputError? validator(String value) {
    return value.isEmpty ? null : ActivityPriceRegExp.hasMatch(value) ? null : ActivityPriceInputError.invalid;
  }
}