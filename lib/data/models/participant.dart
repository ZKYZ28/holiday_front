class Participant {
  final String id;
  final String lastName;
  final String firstName;
  final String email;
  final String srcImage;

  Participant({
    required this.id,
    required this.lastName,
    required this.firstName,
    required this.email,
    required this.srcImage,
  });
}

class ParticipantMutation {
  final String lastName;
  final String firstName;
  final String email;
  final String srcImage;

  ParticipantMutation({
    required this.lastName,
    required this.firstName,
    required this.email,
    required this.srcImage,
  });
}