class ReviewsEntity {
  final int rating;
  final String comment;
  final String date;
  final String reviewerName;

  ReviewsEntity({
    required this.rating,
    required this.comment,
    required this.date,
    required this.reviewerName,
  });
}