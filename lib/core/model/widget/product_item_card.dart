import 'package:flutter/material.dart';
import 'package:project_graduation/feature/home/domain/entities/product_item_entity.dart';
import 'package:project_graduation/core/theme/app_colors.dart';
import 'package:project_graduation/core/theme/app_dimens.dart';
import 'package:project_graduation/core/theme/app_text_styles.dart';


class ProductItemCard extends StatelessWidget {
  const ProductItemCard({
    super.key,
    required this.item,
    this.currency = 'USD ',
    this.onTap,
   required this.onFavoriteTap,
   required this.isFavorite,
  });


  final ProductItemEntity item;
  final bool isFavorite;
  final String currency;
    final VoidCallback? onTap;
  final VoidCallback? onFavoriteTap;

  @override
  Widget build(BuildContext context) {
    return  InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppDimens.cardRadius),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppDimens.cardRadius),
          border: Border.all(color: AppColors.lightGray),
        ),
        clipBehavior: Clip.antiAlias,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                AspectRatio(
                  aspectRatio: 1,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(AppDimens.cardRadius),
                    ),
                    child: Image.network(
                      item.thumbnail,
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) => Container(
                        color: AppColors.white,
                        child: const Icon(Icons.image_not_supported_outlined),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: AppDimens.spaceS,
                  right: AppDimens.spaceS,
                  child: GestureDetector(
                    onTap: onFavoriteTap,
                    child: Container(
                      width: AppDimens.favoriteButtonSize,
                      height: AppDimens.favoriteButtonSize,
                      alignment: Alignment.center,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Icon(isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: AppDimens.iconS,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppDimens.spaceM),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: AppDimens.spaceXS),
                  Row(
                    children: [
                      Text(currency, style: AppTextStyles.bodyMedium),
                      Text(
                        item.price.toStringAsFixed(0),
                        style: AppTextStyles.bodyMedium,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
      