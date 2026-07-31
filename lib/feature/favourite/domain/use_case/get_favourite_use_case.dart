import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/favourite/domain/entities/favourite_entity.dart';
import 'package:project_graduation/feature/favourite/domain/repo/favourite_repo_interface.dart';

@injectable
class GetFavouriteUseCase {
  final FavouriteRepository repository;

  GetFavouriteUseCase(this.repository);

  Future<ResultApi<FavouriteEntity>> invoke() async {
    return repository.getFavouriteProducts();
  }
}