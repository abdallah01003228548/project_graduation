import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/favourite/domain/repo/favourite_repo_interface.dart';

@injectable
class AddFavouriteUseCase {
  final FavouriteRepository repository;

  AddFavouriteUseCase(this.repository);

  Future<ResultApi<String>> invoke(int productId) async {
    return await repository.addFavourite(productId);
  }
}