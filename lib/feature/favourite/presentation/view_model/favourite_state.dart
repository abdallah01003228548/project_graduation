part of 'favourite_cubit.dart';

abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteSuccess extends FavouriteState {
  final List<ProductItemEntity> products;

  FavouriteSuccess({
    required this.products,
  });
}

class FavouriteError extends FavouriteState {
  final String messageError;

  FavouriteError(this.messageError);
}