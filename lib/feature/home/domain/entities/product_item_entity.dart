import 'reviews_entity.dart';
class ProductItemEntity {
  final String id;
  final String name;
  final String description;
  final double price;
  final String thumbnail;
  final String category;
  final List<String> images;
  final double discountPercentage;
  final double rating;
  final List<ReviewsEntity> reviews;


  ProductItemEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.thumbnail,
    required this.category,
    required this.images,
    required this.discountPercentage,
    required this.rating,
    required this.reviews,
  });
}