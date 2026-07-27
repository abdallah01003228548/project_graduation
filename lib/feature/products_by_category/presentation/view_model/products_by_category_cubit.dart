import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/home/domain/entities/product_item_entity.dart';
import 'package:project_graduation/feature/products_by_category/domain/use_case/get_products_by_category_use_case.dart';

part 'products_by_category_state.dart';

@injectable
class ProductsByCategoryCubit extends Cubit<ProductsByCategoryState> {
  final GetProductsByCategoryUseCase _useCase;

  ProductsByCategoryCubit(this._useCase)
      : super(ProductsByCategoryInitial());

  Future<void> getProductsByCategory(String slug) async {
    emit(ProductsByCategoryLoading());

    final result = await _useCase.invoke(slug);

    if (isClosed) return;

    if (result is Success<List<ProductItemEntity>>) {
      if (result.data.isEmpty) {
        emit(ProductsByCategoryEmpty());
      } else {
        emit(ProductsByCategorySuccess(result.data));
      }
    } else if (result is Error<List<ProductItemEntity>>) {
      emit(ProductsByCategoryError(result.messageError));
    }
  }
}