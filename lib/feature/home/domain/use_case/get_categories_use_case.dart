import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/home/domain/entities/category_entity.dart';
import 'package:project_graduation/feature/home/domain/repo/home_repo_interface.dart';

@injectable
class GetCategoriesUseCase {
  final HomeRepository _homeRepository;

  GetCategoriesUseCase(this._homeRepository);

  Future<ResultApi<List<CategoryEntity>>> invoke() async {
    return await _homeRepository.getCategories();
  }
}