import 'package:flutter/material.dart';
import 'package:project_graduation/core/model/widget/product_item_card.dart';
import 'package:project_graduation/core/theme/app_colors.dart';
import 'package:project_graduation/core/theme/app_dimens.dart';
import 'package:project_graduation/core/theme/app_spacing.dart';
import 'package:project_graduation/core/theme/app_text_styles.dart';

import '/core/model/item/product_item_entity.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Set<String> _favoriteIds = {};
  @override
  Widget build(BuildContext context) {
    final products = _dummyProducts;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 2,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'T-shirts',
          style: AppTextStyles.h2Heading,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: AppColors.charcoal),
            onPressed: () {
            },
          ),
        ],
      ),
      body: Padding(
        padding: AppSpacing.screenHorizontal,
        child: SingleChildScrollView(
          child: Wrap(
          spacing: AppSpacing.base2x,
          runSpacing: AppSpacing.base3x,
          children: products.map((item) {
          return SizedBox(
            width: AppDimens.productCardWidth,
            child: ProductItemCard(
              item: item,
              isFavorite: _favoriteIds.contains(item.id),
              onFavoriteTap: () {
                setState(() {
                  if (_favoriteIds.contains(item.id)) {
                    _favoriteIds.remove(item.id);
                  } else {
                    _favoriteIds.add(item.id);
                  }
                });
              },
            ),
             );
           }).toList(),
          ),
        )
      ),
    );
  }
}

final List<ProductItemEntity> _dummyProducts = [
  ProductItemEntity(
    id: '1',
    name: 'T-shirt oversize',
    description: 'Black oversize cotton t-shirt.',
    price: 199,
    thumbnail: 'https://media.istockphoto.com/id/483960103/photo/blank-black-t-shirt-front-with-clipping-path.jpg?s=612x612&w=0&k=20&c=d8qlXILMYhugXGw6zX7Jer2SLPrLPORfsDsfRDWc-50=',
  ),
];