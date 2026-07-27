import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_graduation/core/di/service_locator.dart';
import 'package:project_graduation/core/widget/product_item_card.dart';
import 'package:project_graduation/feature/products_by_category/presentation/view_model/products_by_category_cubit.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  final String slug;
  final String categoryName;

  const ProductsByCategoryScreen({
    super.key,
    required this.slug,
    required this.categoryName,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
      serviceLocator<ProductsByCategoryCubit>()
        ..getProductsByCategory(slug),
      child: Scaffold(
        appBar: AppBar(
          title: Text(categoryName),
        ),
        body: BlocBuilder<
            ProductsByCategoryCubit,
            ProductsByCategoryState>(
          builder: (context, state) {
            if (state is ProductsByCategoryLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is ProductsByCategoryError) {
              return Center(
                child: Text(state.messageError),
              );
            }

            if (state is ProductsByCategoryEmpty) {
              return const Center(
                child: Text('No products in this category'),
              );
            }

            if (state is ProductsByCategorySuccess) {
              return GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: state.products.length,
                gridDelegate:
                const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: .65,
                ),
                itemBuilder: (context, index) {
                  return ProductItemCard(
                    product: state.products[index],
                  );
                },
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}