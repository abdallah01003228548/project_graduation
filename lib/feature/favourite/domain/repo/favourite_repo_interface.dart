import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/home/domain/entities/product_item_entity.dart';

abstract interface class FavouriteRepository {
  Future<ResultApi<List<ProductItemEntity>>> getFavouriteProducts();

  Future<ResultApi<String>> addFavourite(int productId);

  Future<ResultApi<String>> deleteFavourite(int productId);
}
