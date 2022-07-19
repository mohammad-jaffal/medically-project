import 'dart:ffi';

class User {
  int id;
  String name;
  String email;
  String base64Image;
  int balance;
  int type;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.base64Image,
    required this.balance,
    required this.type,
  });
}
