import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/di/network_module.dart';
import 'package:project_graduation/core/model/item/product_item_dto.dart';
import 'package:project_graduation/core/network/api/api_constants.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/cart/data/data_source/cart_remote_data_source.dart';

@LazySingleton(as: CartRemoteDataSource)
class CartRemoteDataSourceImp implements CartRemoteDataSource {
  final NetworkModule networkModule;
  CartRemoteDataSourceImp({required this.networkModule});

  @override
  Future<ResultApi<void>> addToCart(
     String productId,int quantity) async {
    try {
      await networkModule.post(
        ApiConstants.addCart,
        data: {
          'productId': productId.toString(),
          'quantity': quantity,
        },
      );
      return Success(null);
    } on DioException catch (e) {
      return Error(_cartErrorMessage(e, 'Failed to add to cart'));
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<List<ProductItemDto>>> getCart() async {
    try {
      final response = await networkModule.get(
        ApiConstants.getCart,
      );

      final List<dynamic> list = response.data['list'];

      final products = list
          .map(
            (json) => ProductItemDto.fromJson(
              json as Map<String, dynamic>,
            ),
          )
          .toList();
      return Success(products);
    } on DioException catch (e) {
      
      return Error(_cartErrorMessage(e, 'Failed to fetch cart'));
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<void>> deleteCart(String productId) async {
    try {
      await networkModule.delete(
        ApiConstants.deleteCart,
        data: {
          'productId': productId.toString(),
        },
      );
      return Success(null);
    } on DioException catch (e) {
      return Error(_cartErrorMessage(e, 'Failed to remove from cart'));
    } catch (e) {
      return Error(e.toString());
    }
  }

  String _cartErrorMessage(DioException exception, String fallback) {
    if (exception.response?.statusCode == 404) {
      return 'Cart service is unavailable right now. Please try again later.';
    }

    final responseData = exception.response?.data;

    if (responseData is Map<String, dynamic>) {
      final message = responseData['message']?.toString();
      if (message != null && message.isNotEmpty) {
        return message;
      }
    }

    if (responseData is String && responseData.trim().isNotEmpty) {
      return responseData;
    }

    return fallback;
  }
}
