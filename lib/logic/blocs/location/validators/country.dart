import 'package:formz/formz.dart';

enum CountryInputError  { empty, invalid }

extension CountryInputErrorExtension on CountryInputError {
  String get message {
    switch (this) {
      case CountryInputError.empty:
        return "Merci de spécifier le pays.";
      case CountryInputError.invalid:
        return 'Veuillez entrer un nom de pays valide entre 3 et 50 caractères. Les lettres, chiffres, apostrophes, tirets et espaces sont autorisés.';
      default:
        return 'Erreur inconnue. Veuillez contacter un administrateur.';
    }
  }
}

class CountryInput extends FormzInput <String, CountryInputError> {
  const CountryInput.pure() : super.pure('');
  const CountryInput.dirty({String value = ''}) : super.dirty(value);

  static final  CountryRegExp = RegExp(
      r"^[A-Za-z\dÀ-ÿ '\-,]{3,50}$"
  );

  @override
 CountryInputError? validator(String value) {
    return value.isEmpty ?  CountryInputError.empty :  CountryRegExp.hasMatch(value) ? null : CountryInputError.invalid;
  }
}