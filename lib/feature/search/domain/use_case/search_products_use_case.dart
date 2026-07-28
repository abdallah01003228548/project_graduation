import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/home/domain/entities/product_item_entity.dart';
import 'package:project_graduation/feature/search/domain/repo/search_repo_interface.dart';

@injectable
class SearchProductsUseCase {
  final SearchRepoInterface _searchRepo;

  SearchProductsUseCase(this._searchRepo);

  Future<ResultApi<List<ProductItemEntity>>> invoke(
    String query,
  ) {
    return _searchRepo.searchProducts(query);
  }
}