import 'package:project_graduation/core/model/item/product_item_dto.dart';
import 'package:project_graduation/core/network/api/result_api.dart';

abstract interface class CartRemoteDataSource {
  Future<ResultApi<List<ProductItemDto>>> getCart();
  Future<ResultApi<void>> addToCart( String productId, int quantity);
  Future<ResultApi<void>> deleteCart(String productId);
}
