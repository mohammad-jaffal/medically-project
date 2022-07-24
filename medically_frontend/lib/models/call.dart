import 'dart:ffi';

class Call {
  int id;
  int user_id;
  int doctor_id;
  String name;
  String call_image;
  int duration;
  var date;

  Call({
    required this.id,
    required this.user_id,
    required this.doctor_id,
    required this.name,
    required this.call_image,
    required this.duration,
    required this.date,
  });

  factory Call.fromJson(Map<String, dynamic> json) {
    return Call(
      id: json['id'],
      user_id: json['user_id'],
      doctor_id: json['doctor_id'],
      name: json['name'],
      call_image: json['profile_picture'],
      duration: json['duration'],
      date: json['created_at'],
    );
  }
}
