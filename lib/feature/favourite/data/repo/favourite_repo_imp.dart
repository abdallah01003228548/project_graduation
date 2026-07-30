import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/model/item/product_item_dto.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/favourite/domain/repo/favourite_data_source_interface.dart';
import 'package:project_graduation/feature/favourite/domain/repo/favourite_repo_interface.dart';
import 'package:project_graduation/feature/home/domain/entities/product_item_entity.dart';

@Injectable(as: FavouriteRepository)
class FavouriteRepoImp implements FavouriteRepository {
  final FavouriteDataSource _remoteDataSource;

  FavouriteRepoImp(this._remoteDataSource);

  @override
  Future<ResultApi<List<ProductItemEntity>>> getFavouriteProducts() async {
    final result = await _remoteDataSource.getFavouriteProducts();

    if (result is Success<List<ProductItemDto>>) {
      final entities = result.data
          .map((dto) => dto.toEntity())
          .toList();

      return Success(entities);
    }

    if (result is Error<List<ProductItemDto>>) {
      return Error(result.messageError);
    }

    return Error('Unknown error');
  }

  @override
  Future<ResultApi<String>> addFavourite(int productId) async {
    return await _remoteDataSource.addFavourite(productId);
  }

  @override
  Future<ResultApi<String>> deleteFavourite(int productId) async {
    return await _remoteDataSource.deleteFavourite(productId);
  }
}
