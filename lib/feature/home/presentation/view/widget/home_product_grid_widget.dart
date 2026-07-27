import 'package:flutter/material.dart';
import 'package:project_graduation/core/model/widget/product_item_card.dart';
import 'package:project_graduation/core/theme/app_spacing.dart'; // adjust import path to your existing ProductItemCard
import 'package:project_graduation/feature/home/domain/entities/product_item_entity.dart';

class HomeProductGrid extends StatelessWidget {
  final List<ProductItemEntity> products;
  final Set<String> favoriteIds;
  final void Function(String productId) onFavoriteTap;

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
            onFavoriteTap: () => onFavoriteTap(item.id),
          );
        }, childCount: products.length),
      ),
    );
  }
}
