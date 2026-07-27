import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/home/domain/entities/product_item_entity.dart';
import 'package:project_graduation/feature/home/domain/repo/home_repo_interface.dart';

@injectable
class GetProductsUseCase {
  final HomeRepository repository;
  GetProductsUseCase(this.repository);

  Future<ResultApi<List<ProductItemEntity>>> invoke() async {
    return await repository.getProducts();
  }
}