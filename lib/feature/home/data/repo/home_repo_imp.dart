import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/home/data/dto/category_dto.dart';
import 'package:project_graduation/feature/home/data/dto/product_item_dto.dart';
import 'package:project_graduation/feature/home/data/models/data_source/home_remote_data_source.dart';
import 'package:project_graduation/feature/home/domain/entities/category_entity.dart';
import 'package:project_graduation/feature/home/domain/entities/product_item_entity.dart';
import 'package:project_graduation/feature/home/domain/repo/home_repo_interface.dart';

@Injectable(as: HomeRepository)
class HomeRepoImp implements HomeRepository {
  final HomeRemoteDataSource _remoteDataSource;

  HomeRepoImp(this._remoteDataSource);

  @override
  Future<ResultApi<List<CategoryEntity>>> getCategories() async {
    final result = await _remoteDataSource.getCategories();

    if (result is Success<List<CategoryItemDto>>) {
      final entities = result.data.map((dto) => dto.toEntity()).toList();
      return Success(entities);
    } 
    if (result is Error<List<CategoryItemDto>>) {
      return Error(result.messageError);
    }
    return Error('Unknown error');
  }

  @override
  Future<ResultApi<List<ProductItemEntity>>> getProducts() async {
    final result = await _remoteDataSource.getProducts();

    if (result is Success<List<ProductItemDto>>) {
      final entities = result.data.map((dto) => dto.toEntity()).toList();
      return Success(entities);
    }
    if (result is Error<List<ProductItemDto>>) {
      return Error(result.messageError);
    }
    return Error('Unknown error');
  }
}