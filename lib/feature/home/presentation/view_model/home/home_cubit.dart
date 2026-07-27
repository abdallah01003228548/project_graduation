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
  HomeCubit(this._getCategories, this._getProducts) : super(HomeInitial());

  Future<void> getHomeData() async {
    emit(HomeLoading());

    final categoriesResult = await _getCategories.invoke();
    final productsResult = await _getProducts.invoke();

    if (productsResult is Error<List<ProductItemEntity>>) {
      emit(HomeError(productsResult.messageError));
      return;
    }

    if (productsResult is! Success<List<ProductItemEntity>>) {
      emit(HomeError('Unknown error'));
      return;
    }

    final products = productsResult.data;

    final productCategories = products
        .map((product) => product.category.trim())
        .where((category) => category.isNotEmpty)
        .toSet();

    final apiCategories = categoriesResult is Success<List<CategoryEntity>>
        ? categoriesResult.data
              .map((category) => category.name.trim())
              .where((category) => category.isNotEmpty)
        : const <String>[];

    final categories = <String>{
      ...productCategories,
      ...apiCategories,
    }.toList();

    emit(HomeSuccess(products: products, categories: categories));
  }
}
