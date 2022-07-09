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
}
