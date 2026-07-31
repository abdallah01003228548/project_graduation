import 'package:project_graduation/core/model/item/product_item_dto.dart';
import 'package:project_graduation/feature/favourite/domain/entities/favourite_entity.dart';

class FavouriteDto {
  final List<ProductItemDto> products;

  FavouriteDto({
    required this.products,
  });

  factory FavouriteDto.fromJson(Map<String, dynamic> json) {
    return FavouriteDto(
      products: (json['list'] as List<dynamic>)
          .map(
            (e) => ProductItemDto.fromJson(
          e as Map<String, dynamic>,
        ),
      )
          .toList(),
    );
  }

  FavouriteEntity toEntity() {
    return FavouriteEntity(
      products: products.map((e) => e.toEntity()).toList(),
    );
  }
}