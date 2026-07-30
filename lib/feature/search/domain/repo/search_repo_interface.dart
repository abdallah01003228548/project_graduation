import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/home/domain/entities/product_item_entity.dart';

abstract interface class SearchRepoInterface {
  Future<ResultApi<List<ProductItemEntity>>> searchProducts(String query);
}