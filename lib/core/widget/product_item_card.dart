import 'package:flutter/material.dart';
import 'package:project_graduation/core/theme/app_colors.dart';
import 'package:project_graduation/core/theme/app_text_styles.dart';
import 'package:project_graduation/feature/home/domain/entities/product_item_entity.dart';

class ProductItemCard extends StatelessWidget {
  final ProductItemEntity product;

  const ProductItemCard({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Image.network(
              product.thumbnail,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) => Container(
                color: AppColors.white,
                alignment: Alignment.center,
                child: const Icon(Icons.image_not_supported_outlined),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  'EGP ${product.price}',
                  style: TextStyle(
                    color: AppColors.orangeLight,
                    fontSize: AppTextStyles.h3Heading.fontSize,
                    fontWeight: AppTextStyles.h3Heading.fontWeight,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}