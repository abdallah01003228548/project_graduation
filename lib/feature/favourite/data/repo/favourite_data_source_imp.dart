import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/network/api/api_constants.dart';
import 'package:project_graduation/core/di/network_module.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/favourite/data/model/favourite_dto.dart';
import 'package:project_graduation/feature/favourite/domain/repo/favourite_data_source_interface.dart';

@Injectable(as: FavouriteDataSourceInterface)
class FavouriteDataSourceImp implements FavouriteDataSourceInterface {
  final NetworkModule networkModule;

  FavouriteDataSourceImp(this.networkModule);

  @override
  Future<ResultApi<FavouriteDto>> getFavouriteProducts() async {
    try {
      final response = await networkModule.get(
        ApiConstants.getFavourite,
      );

      final favouriteDto = FavouriteDto.fromJson(response.data);

      return Success(favouriteDto);
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
        ApiConstants.addFavourite,
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
        ApiConstants.deleteFavourite,
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