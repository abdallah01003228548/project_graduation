import 'package:project_graduation/core/model/item/product_item_dto.dart';
import 'package:project_graduation/core/network/api/result_api.dart';

abstract interface class FavouriteDataSource {
  Future<ResultApi<List<ProductItemDto>>> getFavouriteProducts();

  Future<ResultApi<String>> addFavourite(int productId);

  Future<ResultApi<String>> deleteFavourite(int productId);
}