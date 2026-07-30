import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:project_graduation/core/network/api/result_api.dart';
import 'package:project_graduation/feature/cart/domain/entities/cart_item_entity.dart';
import 'package:project_graduation/feature/cart/domain/use_case/add_cart_use_case.dart';
import 'package:project_graduation/feature/cart/domain/use_case/delete_cart_use_case.dart';
import 'package:project_graduation/feature/cart/domain/use_case/get_cart_use_case.dart';

part 'cart_state.dart';

@injectable
class CartCubit extends Cubit<CartState> {
  final GetCartUseCase _getCartUseCase;
  final AddCartUseCase _addToCartUseCase;
  final DeleteCartUseCase _deleteFromCartUseCase;

  CartCubit(
    this._getCartUseCase,
    this._addToCartUseCase,
    this._deleteFromCartUseCase,
  ) : super(CartInitial());

  List<CartItemEntity> cartItems = [];

  double get totalPrice {
    return cartItems.fold<double>(
      0.0,
      (total, item) => total + item.totalPrice,
    );
  }
  Future<void> getCart() async {
    if (isClosed) return;

    emit(CartLoading());

    final result = await _getCartUseCase.invoke();

    if (isClosed) return;

    if (result is Success<List<CartItemEntity>>) {
      cartItems = List<CartItemEntity>.from(result.data);

      _emitCurrentCart();
      return;
    }

    if (result is Error<List<CartItemEntity>>) {
      emit(
        CartError(
          errorMessage: result.messageError,
        ),
      );
    }
  }


  Future<void> addToCart(int productId) async {
    final result = await _addToCartUseCase(
      productId.toString(),
      1,
    );

    if (isClosed) return;

    if (result is Success<void>) {
      // Refresh local cart from backend.
      await _refreshCart();

      if (isClosed) return;

      emit(
        CartItemAdded(
          message: 'Item added to cart successfully',
        ),
      );

      return;
    }

    if (result is Error<void>) {
      emit(
        CartItemAddError(
          errorMessage: result.messageError,
        ),
      );
    }
  }

  Future<void> deleteFromCart(int productId) async {
    final result = await _deleteFromCartUseCase(productId);

    if (isClosed) return;

    if (result is Success<void>) {
      cartItems.removeWhere(
        (item) => item.productId == productId.toString(),
      );

      if (cartItems.isEmpty) {
        emit(CartEmpty());
        return;
      }

      emit(
        CartItemDeleted(
          List<CartItemEntity>.from(cartItems),
          totalPrice,
        ),
      );

      return;
    }

    if (result is Error<void>) {
      emit(
        CartItemDeleteError(
          errorMessage: result.messageError,
        ),
      );
    }
  }


  void increaseQuantity(String productId) {
    final index = cartItems.indexWhere(
      (item) => item.productId == productId,
    );

    if (index == -1) return;

    final item = cartItems[index];

    cartItems[index] = item.copyWith(
      quantity: item.quantity + 1,
    );

    emit(
      CartQuantityUpdated(
        List<CartItemEntity>.from(cartItems),
        totalPrice,
      ),
    );
  }


  void decreaseQuantity(String productId) {
    final index = cartItems.indexWhere(
      (item) => item.productId == productId,
    );

    if (index == -1) return;

    final item = cartItems[index];

    if (item.quantity <= 1) return;

    cartItems[index] = item.copyWith(
      quantity: item.quantity - 1,
    );

    emit(
      CartQuantityUpdated(
        List<CartItemEntity>.from(cartItems),
        totalPrice,
      ),
    );
  }


  void _emitCurrentCart() {
    if (isClosed) return;

    if (cartItems.isEmpty) {
      emit(CartEmpty());
      return;
    }

    emit(
      CartSuccess(
        cartItems: List<CartItemEntity>.from(cartItems),
        totalPrice: totalPrice,
      ),
    );
  }

  Future<void> _refreshCart() async {
    final result = await _getCartUseCase.invoke();

    if (isClosed) return;

    if (result is Success<List<CartItemEntity>>) {
      cartItems = List<CartItemEntity>.from(result.data);
    }
  }
}