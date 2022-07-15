import 'dart:ffi';

class User {
  final int id;
  final String name;
  final String email;
  final String base64Image;
  int balance;
  final int type;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.base64Image,
    required this.balance,
    required this.type,
  });
}
