class Profile {
  final String firstName;
  final String lastName;
  final String email;

  const Profile({
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  Profile copyWith({
    String? firstName,
    String? lastName,
    String? email,
  }) {
    return Profile(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
    );
  }
}