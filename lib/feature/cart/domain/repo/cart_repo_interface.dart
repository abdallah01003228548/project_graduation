import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/cart/domain/entities/cart_item_entity.dart';

abstract interface class CartRepoInterface {
  Future<ResultApi<List<CartItemEntity>>> getCart();
  Future<ResultApi<void>> addToCart(String productId, int quantity);
  Future<ResultApi<void>> deleteFromCart(String productId);
}