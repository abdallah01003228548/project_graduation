import 'package:flutter/material.dart';
import 'package:project_graduation/core/model/item/product_item_entity.dart';
import 'package:project_graduation/core/widget/product_item_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: const Center(
        child: ProductItemCard(
          product: ProductItemEntity(
            id: 1,
            title: 'Sample Product',
            description: 'This is a sample product description.',
            category: 'Electronics',
            price: 99.99,
            brand: 'Sample Brand',
            thumbnail: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEA3G12SrovhHRKSoXRWMgDwgVfl9UbIjKRvzsem81EQ&s=10'
          ),
        ),
      ),
    );
  }
}