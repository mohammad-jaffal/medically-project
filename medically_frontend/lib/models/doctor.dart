import 'dart:ffi';

class Doctor {
  int id;
  String name;
  String email;
  String base64Image;
  int balance;
  int type;
  double rating;
  String channelName;
  String channelToken;
  String bio;
  int domainId;
  bool online;

  Doctor({
    required this.id,
    required this.name,
    required this.email,
    required this.base64Image,
    required this.balance,
    required this.type,
    required this.rating,
    required this.channelName,
    required this.channelToken,
    required this.bio,
    required this.domainId,
    required this.online,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['doctor_id'],
      name: json['name'],
      email: json['email'],
      base64Image: json['profile_picture'].toString(),
      balance: json['balance'],
      type: json['type'],
      rating: double.parse(json['rating']),
      channelName: json['channel_name'],
      channelToken: json['channel_token'],
      bio: json['bio'],
      domainId: json['domain_id'],
      online: json['online'] == 1,
    );
  }
}
