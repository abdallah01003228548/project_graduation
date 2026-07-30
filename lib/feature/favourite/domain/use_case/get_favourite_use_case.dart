
import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/favourite/domain/repo/favourite_repo_interface.dart';
import 'package:project_graduation/feature/home/domain/entities/product_item_entity.dart';

@injectable
class GetFavouriteUseCase {
  final FavouriteRepository repository;

  GetFavouriteUseCase(this.repository);

  Future<ResultApi<List<ProductItemEntity>>> invoke() async {
    return await repository.getFavouriteProducts();
  }
}