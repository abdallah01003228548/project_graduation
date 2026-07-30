import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/di/network_module.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/home/data/dto/category_dto.dart';
import 'package:project_graduation/core/model/item/product_item_dto.dart';

abstract interface class HomeRemoteDataSource {
  Future<ResultApi<List<ProductItemDto>>> getProducts();

  Future<ResultApi<List<CategoryItemDto>>> getCategories();

  Future<ResultApi<List<ProductItemDto>>> getProductsByCategory(
      String slug,
      );
}

@Injectable(as: HomeRemoteDataSource)
class HomeRemoteDataSourceImp implements HomeRemoteDataSource {
  final NetworkModule networkModule;

  HomeRemoteDataSourceImp(this.networkModule);

  @override
  Future<ResultApi<List<ProductItemDto>>> getProducts() async {
    try {
      final response = await networkModule.get(
        '/home/products',
        queryParameters: {
          'skip': 0,
          'limit': 1000,
        },
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
      return Error(
        e.response?.data?['message']?.toString() ??
            e.message ??
            'Failed to fetch products',
      );
    } catch (e) {
      return Error(e.toString());
    }
  }

  @override
  Future<ResultApi<List<CategoryItemDto>>> getCategories() async {
    try {
      final response = await networkModule.get('/home/categories');

      final List<dynamic> list = response.data['list'];

      final categories = list
          .map(
            (json) => CategoryItemDto.fromJson(
              json as Map<String, dynamic>,
            ),
          )
          .toList();

      return Success(categories);
    } on DioException catch (e) {
      return Error(
        e.response?.data?['message'] ?? e.message ?? 'Failed to fetch categories',
      );
    } catch (e) {
      return Error(e.toString());
    }
  }
  @override
  Future<ResultApi<List<ProductItemDto>>> getProductsByCategory(
      String slug,
      ) async {
    try {
      final response = await networkModule.get(
        '/home/products/category/$slug',
        queryParameters: {
          'skip': 0,
          'limit': 1000,
        },
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
      return Error(
        e.response?.data?['message']?.toString() ??
            e.message ??
            'Failed to fetch products',
      );
    } catch (e) {
      return Error(e.toString());
    }
  }
}