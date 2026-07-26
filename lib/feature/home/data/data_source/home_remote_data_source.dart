import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/home/data/dto/category_dto.dart';
import 'package:project_graduation/core/model/item/product_item_dto.dart';

abstract interface class HomeRemoteDataSource {
   Future<ResultApi<List<ProductItemDto>>> getProducts();
   Future<ResultApi<List<CategoryItemDto>>> getCategories();
 }