import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/di/network_module.dart';
import 'package:project_graduation/core/model/item/product_item_dto.dart';
import 'package:project_graduation/core/network/api/api_constants.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/search/data/data_source/search_remote_data_source.dart';

@Injectable(as: SearchRemoteDataSource)
class SearchRemoteDataSourceImp implements SearchRemoteDataSource {
  final NetworkModule networkModule;

  SearchRemoteDataSourceImp(this.networkModule);

  @override
  Future<ResultApi<List<ProductItemDto>>> searchProducts(
    String query,
  ) async {
    try {
      final response = await networkModule.post(
        ApiConstants.productsFilter,
        data: {
          'search': query,
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
      if (e.response?.statusCode == 404) {
        return Success(<ProductItemDto>[]);
      }

      return Error(
        e.response?.data?['message']?.toString() ??
            e.message ??
            'Failed to search products',
      );
    } catch (e) {
      return Error(e.toString());
    }
  }
}