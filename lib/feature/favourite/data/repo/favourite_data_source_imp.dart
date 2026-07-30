import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/di/network_module.dart';
import 'package:project_graduation/core/model/item/product_item_dto.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/favourite/domain/repo/favourite_data_source_interface.dart';

@Injectable(as: FavouriteDataSource)
class FavouriteDataSourceImp implements FavouriteDataSource {
  final NetworkModule networkModule;

  FavouriteDataSourceImp(this.networkModule);

  @override
  Future<ResultApi<List<ProductItemDto>>> getFavouriteProducts() async {
    try {
      final response = await networkModule.get('/user/getFavorite');

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
      return Error(
        e.response?.data?['message']?.toString() ??
            e.message ??
            'Failed to fetch favourite products',
      );
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<String>> addFavourite(int productId) async {
    try {
      final response = await networkModule.post(
        '/user/addFavorite',
        data: {
          'productId': productId,
        },
      );

      return Success(
        response.data is Map<String, dynamic>
            ? (response.data['message']?.toString() ?? 'Success')
            : response.data.toString(),
      );
    } on DioException catch (e) {
      return Error(
        e.response?.data?['message']?.toString() ??
            e.message ??
            'Failed to add favourite',
      );
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<String>> deleteFavourite(int productId) async {
    try {
      final response = await networkModule.delete(
        '/user/deleteFavorite',
        data: {
          'productId': productId,
        },
      );

      return Success(
        response.data is Map<String, dynamic>
            ? (response.data['message']?.toString() ?? 'Success')
            : response.data.toString(),
      );
    } on DioException catch (e) {
      return Error(
        e.response?.data?['message']?.toString() ??
            e.message ??
            'Failed to delete favourite',
      );
    } catch (e) {
      return Error(e.toString());
    }
  }
}