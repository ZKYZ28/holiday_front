class UserAuthentificated {
  final String id;
  final String firstName;
  final String lastName;
  final String email;

  UserAuthentificated({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
  });
}

class GoogleAuth {
  final String tokenId;

  GoogleAuth({
    required this.tokenId,
  });
}