import 'package:flutter/material.dart';
import 'package:project_graduation/core/model/widget/product_item_card.dart';

import '../../../../../core/model/item/product_item_entity.dart';

/// Home screen showing a grid of products for a category (e.g. T-shirts).
///
/// Currently wired to [_dummyProducts] for UI testing. Replace with a
/// Bloc/Cubit-driven state once the data layer is connected.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Track favorites locally for now (UI-only, no persistence/backend yet).

  @override
  Widget build(BuildContext context) {
    final products = _dummyProducts;

    return Scaffold(
      backgroundColor: Color(0xFFEBEBEB),
      appBar: AppBar(
        backgroundColor: Color(0xFFEBEBEB),
        elevation: 2,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'T-shirts',
          style: TextStyle(
            color: Color(0xFF212121),
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Color(0xFF212121)),
            onPressed: () {
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: SingleChildScrollView(
          child: Wrap(
          spacing: 16,
          runSpacing: 20,
          children: products.map((item) {
          return SizedBox(
            width: 163,
            child: ProductItemCard(item: item),
             );
           }).toList(),
          ),
        )
      ),
    );
  }
}

/// Dummy data used only to validate the grid/card UI.
final List<ProductItemEntity> _dummyProducts = [
  ProductItemEntity(
    id: '1',
    name: 'T-shirt oversize',
    description: 'Black oversize cotton t-shirt.',
    price: 199,
    thumbnail: 'https://picsum.photos/seed/tshirt1/400/400',
  ),
];