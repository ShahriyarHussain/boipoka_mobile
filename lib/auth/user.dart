class User {
  final String firstName;
  final String lastName;
  final String username;
  final String password;

  User(
      {required this.firstName,
      required this.lastName,
      required this.username,
      required this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        firstName: json['first_name'] as String,
        lastName: json['last_name'] as String,
        username: json['username'] as String,
        password: json['password'] as String);
  }

  Map toJsonRegister() => {
        'user': {
          'first_name': firstName,
          'last_name': lastName,
          'username': username,
          'password': password,
        },
      };
}
