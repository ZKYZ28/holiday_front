import 'package:formz/formz.dart';

enum LocalityInputError  { invalid }

extension LocalityInputErrorExtension on LocalityInputError {
  String get message {
    switch (this) {
      case LocalityInputError.invalid:
        return 'Champ faculatif. Si vous choisissez de le remplir, Veuillez saisir une localité valide contenant entre 1 et 100 caractères. Seules les lettres, chiffres, espaces, apostrophes, points, virgules et tirets sont autorisés.';
      default:
        return 'Erreur inconnue. Veuillez contacter un administrateur';
    }
  }
}

class LocalityInput extends FormzInput <String, LocalityInputError> {
  const LocalityInput.pure() : super.pure('');
  const LocalityInput.dirty({String value = ''}) : super.dirty(value);

  static final _LocalityRegExp = RegExp(
      r"^[A-Za-zÀ-ÿ\d '.,\-]{1,100}$"
  );

  @override
  LocalityInputError? validator(String value) {
    return value.isEmpty ?  null : _LocalityRegExp.hasMatch(value) ? null : LocalityInputError.invalid;
  }
}