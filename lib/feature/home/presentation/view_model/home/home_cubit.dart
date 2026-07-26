import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/home/domain/entities/category_entity.dart';
import 'package:project_graduation/feature/home/domain/entities/product_item_entity.dart';
import 'package:project_graduation/feature/home/domain/use_case/get_categories_use_case.dart';
import 'package:project_graduation/feature/home/domain/use_case/get_products_use_case.dart';

part 'home_state.dart';

@injectable
class HomeCubit extends Cubit<HomeState> {
  final GetCategoriesUseCase _getCategories;
  final GetProductsUseCase _getProducts;
  HomeCubit(
    this._getCategories,
    this._getProducts,
  ) : super(HomeInitial());

  Future<void> getHomeData() async {
  emit(HomeLoading());

  final categoriesResult = await _getCategories.invoke();
  final productsResult = await _getProducts.invoke();

  if (productsResult is Error<List<ProductItemEntity>>) {
    emit(HomeError(productsResult.messageError));
    return;
  }

  if (categoriesResult is Error<List<CategoryEntity>>) {
    emit(HomeError(categoriesResult.messageError));
    return;
  }

  if (productsResult is Success<List<ProductItemEntity>> &&
      categoriesResult is Success<List<CategoryEntity>>) {
    emit(
      HomeSuccess(
        products: productsResult.data,
        categories: categoriesResult.data,
      ),
    );
  }
 }
}