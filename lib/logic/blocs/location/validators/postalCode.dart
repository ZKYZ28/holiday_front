import 'package:formz/formz.dart';

enum PostalCodeInputError  { empty, invalid }

extension PostalCodeInputErrorExtension on PostalCodeInputError {
  String get message {
    switch (this) {
      case PostalCodeInputError.empty:
        return "Merci de spécifier le code postal !";
      case PostalCodeInputError.invalid:
        return 'Veuillez saisir un code postal valide entre 1 à 15 caractères. Exemples : 4000, 75000';
      default:
        return 'Erreur inconnue. Veuillez contacter un administrateur.';
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
    return value.isEmpty ?  PostalCodeInputError.empty : _postalCodeRegExp.hasMatch(value) ? null : PostalCodeInputError.invalid;
  }
}