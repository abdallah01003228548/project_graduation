import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/favourite/data/model/favourite_dto.dart';

abstract interface class FavouriteDataSourceInterface {
  Future<ResultApi<FavouriteDto>> getFavouriteProducts();

  Future<ResultApi<String>> addFavourite(int productId);

  Future<ResultApi<String>> deleteFavourite(int productId);
}