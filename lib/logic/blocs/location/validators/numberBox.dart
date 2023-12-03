import 'package:formz/formz.dart';

enum NumberBoxInputError  { invalid }

extension NumberBoxInputErrorExtension on NumberBoxInputError {
  String get message {
    switch (this) {
      case NumberBoxInputError.invalid:
        return 'Champ faculatif. Si vous choisissez de le remplir, veuillez entrer un numéro de boîte valide entre 1 à 10 caractères. Exemples : 77, 77A, PO Box 123, PMB 456B.';
      default:
        return 'Erreur inconnue. Veuillez contacter un administrateur.';
    }
  }
}

class NumberBoxInput extends FormzInput <String, NumberBoxInputError> {
  const NumberBoxInput.pure() : super.pure('');
  const NumberBoxInput.dirty({String value = ''}) : super.dirty(value);

  static final _NumberBoxRegExp = RegExp(
      r'^[A-Za-z\d\- ]{1,10}$'
  );

  @override
  NumberBoxInputError? validator(String value) {
    return value.isEmpty ?  null : _NumberBoxRegExp.hasMatch(value) ? null : NumberBoxInputError.invalid;
  }
}