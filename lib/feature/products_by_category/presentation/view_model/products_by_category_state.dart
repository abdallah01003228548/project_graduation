part of 'products_by_category_cubit.dart';

sealed class ProductsByCategoryState {}

final class ProductsByCategoryInitial extends ProductsByCategoryState {}

final class ProductsByCategoryLoading extends ProductsByCategoryState {}

final class ProductsByCategorySuccess extends ProductsByCategoryState {
  final List<ProductItemEntity> products;

  ProductsByCategorySuccess(this.products);
}

final class ProductsByCategoryEmpty extends ProductsByCategoryState {}

final class ProductsByCategoryError extends ProductsByCategoryState {
  final String messageError;

  ProductsByCategoryError(this.messageError);
}