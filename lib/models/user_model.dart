import 'dart:convert';

class User {
  final String id;
  final String username;
  final String email;
  final String token;
  final String password;
  final String isVerified;

  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.token,
      required this.password,
      required this.isVerified});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'token': token,
      'password': password,
      'isVerified': isVerified
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] ?? '',
      username: map['username'] ?? '',
      email: map['email'] ?? '',
      token: map['token'] ?? '',
      password: map['password'] ?? '',
      isVerified: map['isVerified'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source));
}
