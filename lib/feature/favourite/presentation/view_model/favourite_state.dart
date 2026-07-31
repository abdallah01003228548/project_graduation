part of 'favourite_cubit.dart';

abstract class FavouriteState {}

class FavouriteInitial extends FavouriteState {}

class FavouriteLoading extends FavouriteState {}

class FavouriteSuccess extends FavouriteState {
  final FavouriteEntity favourite;

  FavouriteSuccess({
    required this.favourite,
  });
}

class FavouriteError extends FavouriteState {
  final String messageError;

  FavouriteError(this.messageError);
}