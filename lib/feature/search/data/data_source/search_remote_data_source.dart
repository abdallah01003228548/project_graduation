import 'package:project_graduation/core/model/item/product_item_dto.dart';
import 'package:project_graduation/core/network/api/result_api.dart';

abstract interface class SearchRemoteDataSource {
  Future<ResultApi<List<ProductItemDto>>> searchProducts(String query);
  
}