import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/home/domain/entities/product_item_entity.dart';
import 'package:project_graduation/feature/home/domain/repo/home_repo_interface.dart';

@injectable
class GetProductsByCategoryUseCase {
  final HomeRepository repository;

  GetProductsByCategoryUseCase(this.repository);

  Future<ResultApi<List<ProductItemEntity>>> invoke(
      String slug,
      ) async {
    return await repository.getProductsByCategory(slug);
  }
}