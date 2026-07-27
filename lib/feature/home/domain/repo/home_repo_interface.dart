import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/home/domain/entities/category_entity.dart';
import 'package:project_graduation/feature/home/domain/entities/product_item_entity.dart';

abstract interface class HomeRepository {
  Future<ResultApi<List<CategoryEntity>>> getCategories();

  Future<ResultApi<List<ProductItemEntity>>> getProducts();

  Future<ResultApi<List<ProductItemEntity>>> getProductsByCategory(
      String slug,
      );
}