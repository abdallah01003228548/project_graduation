import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_graduation/feature/cart/presentation/view_model/cart/cart_cubit.dart';
import 'package:project_graduation/feature/favourite/presentation/view_model/favourite_cubit.dart';
import 'package:project_graduation/feature/product_details/presentation/view/screens/product_details_screen.dart';
import 'package:project_graduation/core/model/widget/product_item_card.dart';
import 'package:project_graduation/core/theme/app_spacing.dart'; // adjust import path to your existing ProductItemCard
import 'package:project_graduation/feature/home/domain/entities/product_item_entity.dart';

class HomeProductGrid extends StatelessWidget {
  final List<ProductItemEntity> products;
  final Set<String> favoriteIds;
  final void Function(ProductItemEntity product) onFavoriteTap;

  const HomeProductGrid({
    super.key,
    required this.products,
    required this.favoriteIds,
    required this.onFavoriteTap,
  });

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: AppSpacing.screenHorizontal,
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.62,
        ),
        delegate: SliverChildBuilderDelegate((context, index) {
          final item = products[index];

          return ProductItemCard(
            item: item,
            isFavorite: favoriteIds.contains(item.id),
            onFavoriteTap: () => onFavoriteTap(item),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                          value: context.read<CartCubit>(),
                          child: BlocProvider.value(
                            value: context.read<FavouriteCubit>(),
                            child: ProductDetailsScreen(product: item),
                          ),
                  ),
                ),
              );
            },
          );
        }, childCount: products.length),
      ),
    );
  }
}
