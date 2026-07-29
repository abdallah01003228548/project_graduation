import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/model/item/product_item_dto.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/cart/data/data_source/cart_remote_data_source.dart';
import 'package:project_graduation/feature/cart/domain/entities/cart_item_entity.dart';
import 'package:project_graduation/feature/cart/domain/repo/cart_repo_interface.dart';

@LazySingleton(as: CartRepoInterface)
class CartRepoImp implements CartRepoInterface {
  final CartRemoteDataSource cartRemoteDataSource;
  CartRepoImp({required this.cartRemoteDataSource});

  @override
  Future<ResultApi<void>> addToCart(String productId, int quantity) async {
    return await cartRemoteDataSource.addToCart(productId, quantity);
  }

  @override
Future<ResultApi<List<CartItemEntity>>> getCart() async {
  final result = await cartRemoteDataSource.getCart();

  if (result is Success<List<ProductItemDto>>) {
    final cartItems = result.data
        .map(
          (dto) => CartItemEntity(
            product: dto.toEntity(),
            quantity: 1,
          ),
        )
        .toList();

    return Success(cartItems);
  }

  if (result is Error<List<ProductItemDto>>) {
    return Error(result.messageError);
  }

  return Error('Failed to fetch cart');
}

  @override
  Future<ResultApi<void>> deleteFromCart(String productId) {
    return cartRemoteDataSource.deleteCart(productId);
  }
  
}