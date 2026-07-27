import 'package:flutter/material.dart';
import 'package:project_graduation/core/widget/product_item_card.dart';
import 'package:project_graduation/feature/home/domain/entities/product_item_entity.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: Center(
        child: ProductItemCard(
          product: ProductItemEntity(
            id: '1',
            name: 'Sample Product',
            description: 'This is a sample product description.',
            price: 99.99,
            thumbnail: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSEA3G12SrovhHRKSoXRWMgDwgVfl9UbIjKRvzsem81EQ&s=10',
            category: 'Sample Category',
          ),
        ),
      ),
    );
  }
}