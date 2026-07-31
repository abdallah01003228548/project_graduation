import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_graduation/core/theme/app_colors.dart';
import 'package:project_graduation/core/theme/app_text_styles.dart';
import 'package:project_graduation/feature/cart/domain/entities/cart_item_entity.dart';
import 'package:project_graduation/feature/cart/presentation/view/widget/cart_item_widget.dart';
import 'package:project_graduation/feature/cart/presentation/view_model/cart/cart_cubit.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text('My Cart'),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is CartEmpty) {
            return const _EmptyCart();
          }

          if (state is CartError) {
            return Center(
              child: Text(state.errorMessage),
            );
          }

          if (state is CartSuccess) {
            return _CartContent(
              cartItems: state.cartItems,
              totalPrice: state.totalPrice,
            );
          }

          if (state is CartItemDeleted) {
            return _CartContent(
              cartItems: state.cartItems,
              totalPrice: state.totalPrice,
            );
          }
          if (state is CartQuantityUpdated) {
            return _CartContent(
              cartItems: state.cartItems,
              totalPrice: state.totalPrice,
            );
          }

          final cubit = context.read<CartCubit>();

          if (cubit.cartItems.isNotEmpty) {
            return _CartContent(
              cartItems: List<CartItemEntity>.from(cubit.cartItems),
              totalPrice: cubit.totalPrice,
            );
          }

          return const _EmptyCart();
        },
      ),
    );
  }
}

class _CartContent extends StatelessWidget {
  final List<CartItemEntity> cartItems;
  final double totalPrice;

  const _CartContent({
    required this.cartItems,
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];

              return CartItemWidget(
                item: item,
                onIncrease: () {
                  context.read<CartCubit>().increaseQuantity(
                        item.productId,
                      );
                },
                onDecrease: () {
                  context.read<CartCubit>().decreaseQuantity(
                        item.productId,
                      );
                },
                onDelete: () {
                  context.read<CartCubit>().deleteFromCart(
                        int.parse(item.productId),
                      );
                },
              );
            },
          ),
        ),
        _CheckoutSection(
          totalPrice: totalPrice,
        ),
      ],
    );
  }
}

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.shopping_cart_outlined,
            size: 80,
          ),
          SizedBox(height: 16),
          Text(
            'Your cart is empty',
            style: AppTextStyles.bodyLarge,
          ),
        ],
      ),
    );
  }
}

class _CheckoutSection extends StatelessWidget {
  final double totalPrice;

  const _CheckoutSection({
    required this.totalPrice,
  });

  @override
  Widget build(BuildContext context) {
    const double shippingFee = 45.0;

    final double finalTotal = totalPrice + shippingFee;

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Shipping fee'),
                Text(
                  'USD ${shippingFee.toStringAsFixed(2)}',
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Sub total'),
                Text(
                  'USD ${totalPrice.toStringAsFixed(2)}',
                  style: AppTextStyles.bodyMedium,
                ),
              ],
            ),
            const Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Total',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'USD ${finalTotal.toStringAsFixed(2)}',
                  style: AppTextStyles.bodyMedium.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Checkout'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
