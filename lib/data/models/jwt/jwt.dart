class Jwt {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final num exp;

  Jwt({
  required this.id,
  required this.firstName,
  required this.lastName,
  required this.email,
  required this.exp,
  });
}