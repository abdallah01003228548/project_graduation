import 'package:flutter/material.dart';
import 'package:project_graduation/core/theme/app_colors.dart';
import 'package:project_graduation/core/theme/app_text_styles.dart';
import 'package:project_graduation/feature/cart/domain/entities/cart_item_entity.dart';

class CartItemWidget extends StatelessWidget {
  final CartItemEntity item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onDelete;

  const CartItemWidget({
    super.key,
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              item.product.thumbnail,
              width: 85,
              height: 85,
              fit: BoxFit.cover,
              errorBuilder: (_, __, ___) {
                return Container(
                  width: 85,
                  height: 85,
                  color: AppColors.background,
                  child: const Icon(Icons.image_outlined),
                );
              },
            ),
          ),

          const SizedBox(width: 12),

          // Title + price
          Expanded(
            child: SizedBox(
              height: 85,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodyMedium
                  ),
  
                  const Spacer(),

                  Text(
                    'EGP ${item.unitPrice.toStringAsFixed(2)}',
                    style: AppTextStyles.bodyMedium
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 85,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                InkWell(
                  onTap: onDelete,
                  child: const Icon(
                    Icons.close,
                    size: 22,
                  ),
                ),

                const Spacer(),

                Row(
                  children: [
                    _QuantityButton(
                      icon: Icons.remove,
                      onTap: onDecrease,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                      ),
                      child: Text(
                        '${item.quantity}',
                        style: AppTextStyles.bodySmall
                      ),
                    ),

                    _QuantityButton(
                      icon: Icons.add,
                      onTap: onIncrease,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _QuantityButton({
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.lightGray,
          ),
        ),
        child: Icon(
          icon,
          size: 16,
        ),
      ),
    );
  }
}