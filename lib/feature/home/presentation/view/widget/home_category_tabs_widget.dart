import 'package:flutter/material.dart';
import 'package:project_graduation/core/theme/app_colors.dart';
import 'package:project_graduation/feature/home/domain/entities/category_entity.dart';

class HomeCategoryTabs extends StatelessWidget {
  final List<CategoryEntity> categories;
  final String selectedCategory;
  final ValueChanged<CategoryEntity> onCategorySelected;

  const HomeCategoryTabs({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category.name == selectedCategory;

          return ChoiceChip(
            label: Text(category.name),
            selected: isSelected,
            onSelected: (_) => onCategorySelected(category),
            labelStyle:
            (Theme.of(context).textTheme.bodyMedium ?? const TextStyle())
                .copyWith(
              color: isSelected ? Colors.white : null,
            ),
            selectedColor: AppColors.orangeLight,
            backgroundColor: AppColors.background,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(100),
              side: BorderSide(
                color:
                isSelected ? AppColors.orangeLight : AppColors.lightGray,
              ),
            ),
          );
        },
      ),
    );
  }
}