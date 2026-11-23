class Tokens {
  Tokens({required this.accessToken, required this.refreshToken});

  final String accessToken;
  final String refreshToken;

  factory Tokens.fromJson(Map<String, dynamic> json) {
    return Tokens(
      accessToken: json['accessToken'],
      refreshToken: json['refreshToken'],
    );
  }
}

class User {
  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.image,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String image;

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      image: json['image'],
    );
  }
}