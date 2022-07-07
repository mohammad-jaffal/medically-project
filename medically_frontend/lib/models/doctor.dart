class Doctor {
  final int id;
  final String name;
  final String email;
  final String base64Image;
  final double rating;
  final String channelName;
  final String channelToken;
  final String bio;
  final int domainId;

  Doctor({
    required this.id,
    required this.name,
    required this.email,
    required this.base64Image,
    required this.rating,
    required this.channelName,
    required this.channelToken,
    required this.bio,
    required this.domainId,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      base64Image: json['profile_picture'],
      rating: json['rating'],
      channelName: json['channel_name'],
      channelToken: json['channel_token'],
      bio: json['bio'],
      domainId: json['domain_id'],
    );
  }
}
