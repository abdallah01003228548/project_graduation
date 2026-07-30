part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartSuccess extends CartState {
  final List<CartItemEntity> cartItems;
  final double totalPrice;
  CartSuccess({required this.cartItems, required this.totalPrice});
}

class CartEmpty extends CartState {}

class CartError extends CartState {
  final String errorMessage;

  CartError({required this.errorMessage});
}

class CartItemAdded extends CartState {
  final String message;

  CartItemAdded({required this.message});
}

class CartItemAddError extends CartState {
  final String errorMessage;

  CartItemAddError({required this.errorMessage});
}
class CartItemDeleted extends CartState {
  final List<CartItemEntity> cartItems;
  final double totalPrice;

  CartItemDeleted(this.cartItems, this.totalPrice);
}

class CartItemDeleteError extends CartState {
  final String errorMessage;

  CartItemDeleteError({required this.errorMessage});
}

class CartQuantityUpdated extends CartState {
  final List<CartItemEntity> cartItems;
  final double totalPrice;

  CartQuantityUpdated(this.cartItems, this.totalPrice,);
}