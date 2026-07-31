import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/di/network_module.dart';
import 'package:project_graduation/core/network/api/api_constants.dart';
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

      final responseData = response.data;

      if (responseData is! Map) {
        return Error(
          'Invalid favourite response: ${responseData.toString()}',
        );
      }

      final data = Map<String, dynamic>.from(responseData);

      final favouriteDto = FavouriteDto.fromJson(data);

      return Success(favouriteDto);
    } on DioException catch (e) {
      return Error(
        _extractDioError(
          e,
          fallback: 'Failed to fetch favourite products',
        ),
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
        _extractSuccessMessage(
          response.data,
          fallback: 'Product added to favourites',
        ),
      );
    } on DioException catch (e) {
      return Error(
        _extractDioError(
          e,
          fallback: 'Failed to add favourite',
        ),
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
        _extractSuccessMessage(
          response.data,
          fallback: 'Product removed from favourites',
        ),
      );
    } on DioException catch (e) {
      return Error(
        _extractDioError(
          e,
          fallback: 'Failed to delete favourite',
        ),
      );
    } catch (e) {
      return Error(e.toString());
    }
  }

  String _extractSuccessMessage(
    dynamic responseData, {
    required String fallback,
  }) {
    if (responseData is Map) {
      final data = Map<String, dynamic>.from(responseData);

      final message = data['message'];

      if (message is String && message.isNotEmpty) {
        return message;
      }

      if (message != null) {
        return message.toString();
      }
    }

    if (responseData is String && responseData.isNotEmpty) {
      return responseData;
    }

    return fallback;
  }

  String _extractDioError(
    DioException exception, {
    required String fallback,
  }) {
    final responseData = exception.response?.data;

    // Backend returned JSON object
    if (responseData is Map) {
      final data = Map<String, dynamic>.from(responseData);

      final message = data['message'];

      if (message != null && message.toString().isNotEmpty) {
        return message.toString();
      }

      final error = data['error'];

      if (error != null && error.toString().isNotEmpty) {
        return error.toString();
      }
    }

    // Backend returned plain text / HTML
    if (responseData is String && responseData.isNotEmpty) {
      return responseData;
    }

    final dioMessage = exception.message;

    if (dioMessage != null && dioMessage.isNotEmpty) {
      return dioMessage;
    }

    return fallback;
  }
}