import 'dart:ffi';

class Call {
  final int id;
  final int doctor_id;
  final String user_name;
  final String doctor_name;
  final String call_image;
  final int duration;

  Call({
    required this.id,
    required this.doctor_id,
    required this.doctor_name,
    required this.user_name,
    required this.call_image,
    required this.duration,
  });

  factory Call.fromJson(Map<String, dynamic> json) {
    return Call(
      id: json['id'],
      doctor_id: json['doctor_id'],
      // user_name: json['user_name'],
      user_name: 'user_name',
      // doctor_name: json['doctor_name'],
      doctor_name: 'doctor_name',
      call_image: json['profile_picture'],
      duration: json['duration'],
    );
  }
}
