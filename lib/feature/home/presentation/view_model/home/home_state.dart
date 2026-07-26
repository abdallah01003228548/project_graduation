part of 'home_cubit.dart';

@immutable
abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<CategoryEntity> categories;
  final List<ProductItemEntity> products;

  HomeSuccess({
    required this.categories,
    required this.products,
  });
}

class HomeError extends HomeState {
  final String messageError;

  HomeError(this.messageError);
}

