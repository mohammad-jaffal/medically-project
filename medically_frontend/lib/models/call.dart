import 'dart:ffi';

class Call {
  final int id;
  final int user_id;
  final int doctor_id;
  final String name;
  final String call_image;
  final int duration;

  Call({
    required this.id,
    required this.user_id,
    required this.doctor_id,
    required this.name,
    required this.call_image,
    required this.duration,
  });

  factory Call.fromJson(Map<String, dynamic> json) {
    return Call(
      id: json['id'],
      user_id: json['user_id'],
      doctor_id: json['doctor_id'],
      name: json['name'],
      call_image: json['profile_picture'],
      duration: json['duration'],
    );
  }
}
