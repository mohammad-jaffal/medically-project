import 'dart:ffi';

class User {
  final int id;
  final String name;
  final String email;
  final String base64Image;
  final int balance;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.base64Image,
    required this.balance,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      base64Image: json['profile_picture'],
      balance: json['balance'],
    );
  }
}
