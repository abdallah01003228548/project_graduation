import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/model/item/product_item_dto.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/home/domain/entities/product_item_entity.dart';
import 'package:project_graduation/feature/search/data/data_source/search_remote_data_source.dart';
import 'package:project_graduation/feature/search/domain/repo/search_repo_interface.dart';

// Change this import to wherever ProductItemDto actually exists.
@Injectable(as: SearchRepoInterface)
class SearchRepoImp implements SearchRepoInterface {
  final SearchRemoteDataSource _remoteDataSource;

  SearchRepoImp(this._remoteDataSource);

  @override
  Future<ResultApi<List<ProductItemEntity>>> searchProducts(
    String query,
  ) async {
    final result = await _remoteDataSource.searchProducts(query);

    if (result is Success<List<ProductItemDto>>) {
      final products = result.data
          .map((dto) => dto.toEntity())
          .toList();

      return Success(products);
    }

    if (result is Error<List<ProductItemDto>>) {
      return Error(result.messageError);
    }

    return Error('Unexpected error');
  }
}