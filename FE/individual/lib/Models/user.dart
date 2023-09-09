class User {
  final String username;
  final String email;
  String password;
  String name;
  String surname;
  String yearOfBirth;
  final String gender;
  int avatarIndex;
  double rating;

  User(
      {required this.username,
      required this.email,
      required this.password,
      required this.name,
      required this.surname,
      required this.yearOfBirth,
      required this.gender,
      required this.avatarIndex,
      required this.rating});
}
