import 'package:project_graduation/feature/favourite/domain/entities/favourite_entity.dart';

class FavouriteItemDto {
  final String id;
  final String name;
  final String description;
  final double price;
  final String thumbnail;

  FavouriteItemDto({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.thumbnail,
  });

  factory FavouriteItemDto.fromJson(Map<String, dynamic> json) {
    return FavouriteItemDto(
      id: json['id'].toString(),
      name: json['title'] ?? '',
      description: json['description'] ?? '',
      price: (json['price'] as num).toDouble(),
      thumbnail: json['thumbnail'] ?? '',
    );
  }

  FavouriteEntity toEntity() {
    return FavouriteEntity(
      id: id,
      name: name,
      description: description,
      price: price,
      thumbnail: thumbnail,
    );
  }
}