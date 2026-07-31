import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/favourite/data/model/favourite_dto.dart';
import 'package:project_graduation/feature/favourite/domain/entities/favourite_entity.dart';
import 'package:project_graduation/feature/favourite/domain/repo/favourite_data_source_interface.dart';
import 'package:project_graduation/feature/favourite/domain/repo/favourite_repo_interface.dart';

@Injectable(as: FavouriteRepository)
class FavouriteRepoImp implements FavouriteRepository {
  final FavouriteDataSourceInterface _remoteDataSource;

  FavouriteRepoImp(this._remoteDataSource);

  @override
  Future<ResultApi<FavouriteEntity>> getFavouriteProducts() async {
    final result = await _remoteDataSource.getFavouriteProducts();

    if (result is Success<FavouriteDto>) {
      return Success(result.data.toEntity());
    }

    if (result is Error<FavouriteDto>) {
      return Error(result.messageError);
    }

    return Error('Unknown error');
  }

  @override
  Future<ResultApi<String>> addFavourite(int productId) {
    return _remoteDataSource.addFavourite(productId);
  }

  @override
  Future<ResultApi<String>> deleteFavourite(int productId) {
    return _remoteDataSource.deleteFavourite(productId);
  }
}