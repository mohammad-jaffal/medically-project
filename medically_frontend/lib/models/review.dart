class Review {
  final int id;
  final int user_id;
  final int doctor_id;
  final int rating;
  final String review_text;

  Review({
    required this.id,
    required this.user_id,
    required this.doctor_id,
    required this.rating,
    required this.review_text,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      id: json['id'],
      user_id: json['user_id'],
      doctor_id: json['doctor_id'],
      rating: json['rating'],
      review_text: json['review_text'],
    );
  }
}
