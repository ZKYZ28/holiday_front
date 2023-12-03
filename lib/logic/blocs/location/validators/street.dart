import 'package:formz/formz.dart';

enum StreetInputError  { invalid }

extension StreetInputErrorExtension on StreetInputError {
  String get message {
    switch (this) {
      case StreetInputError.invalid:
        return 'Champ faculatif. Si vous choisissez de le remplir, veuillez saisir une adresse de rue valide contenant entre 3 et 100 caractères. Seules les lettres, chiffres, espaces, apostrophes, points, virgules et tirets sont autorisés.';
      default:
        return 'Erreur inconnue. Veuillez contacter un administrateur.';
    }
  }
}

class StreetInput extends FormzInput <String, StreetInputError> {
  const StreetInput.pure() : super.pure('');
  const StreetInput.dirty({String value = ''}) : super.dirty(value);

  static final _StreetRegExp = RegExp(
      r"^[A-Za-zÀ-ÿ\d '.,\-]{3,100}$"
  );

  @override
  StreetInputError? validator(String value) {
    return value.isEmpty ?  null : _StreetRegExp.hasMatch(value) ? null : StreetInputError.invalid;
  }
}