import 'dart:ffi';

class Call {
  final int id;
  final int user_id;
  final int doctor_id;
  final int duration;

  Call({
    required this.id,
    required this.user_id,
    required this.doctor_id,
    required this.duration,
  });

  factory Call.fromJson(Map<String, dynamic> json) {
    return Call(
      id: json['id'],
      user_id: json['user_id'],
      doctor_id: json['doctor_id'],
      duration: json['duration'],
    );
  }
}
