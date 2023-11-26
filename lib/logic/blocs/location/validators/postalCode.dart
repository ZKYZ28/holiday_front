import 'package:formz/formz.dart';
import 'package:holiday_mobile/logic/blocs/login_bloc/validators/email.dart';

enum PostalCodeInputError  { invalid }

extension PostalCodeInputErrorExtension on PostalCodeInputError {
  String get message {
    switch (this) {
      case PostalCodeInputError.invalid:
        return 'Champ faculatif. Si vous choisissez de le remplir, veuillez saisir un code postal valide entre 1 à 15 caractères. Exemples : 4000 (Belgique), 75000 (France)';
      default:
        return 'Erreur inconnue. Veuillez contacter un administrateur';
    }
  }
}

class PostalCodeInput extends FormzInput <String, PostalCodeInputError> {
  const PostalCodeInput.pure() : super.pure('');
  const PostalCodeInput.dirty({String value = ''}) : super.dirty(value);

  static final _postalCodeRegExp = RegExp(
      r'^[A-Za-z\d\-, ]{1,15}$'
  );

  @override
  PostalCodeInputError? validator(String value) {
    return value.isEmpty ?  null : _postalCodeRegExp.hasMatch(value) ? null : PostalCodeInputError.invalid;
  }
}