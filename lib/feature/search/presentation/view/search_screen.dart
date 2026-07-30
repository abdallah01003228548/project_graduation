import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_graduation/core/di/service_locator.dart';
import 'package:project_graduation/core/model/widget/product_item_card.dart';
import 'package:project_graduation/core/theme/custom_text_field.dart';
import 'package:project_graduation/feature/cart/presentation/view_model/cart/cart_cubit.dart';
import 'package:project_graduation/feature/product_details/presentation/view/screens/product_details_screen.dart';
import 'package:project_graduation/feature/search/presentation/view_model/search_cubit.dart';
import 'package:project_graduation/feature/search/presentation/view_model/search_state.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<SearchCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
        ),
        body: const _SearchBody(),
      ),
    );
  }

  static void show(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const SearchScreen(),
      ),
    );
  }
}

class _SearchBody extends StatelessWidget {
  const _SearchBody();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: CustomTextField(
            hintText: 'Search products...',
            onChanged: context.read<SearchCubit>().search,
          ),
        ),

        Expanded(
          child: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              return switch (state) {
                SearchInitial() => const Center(
                    child: Text('Search for products'),
                  ),

                SearchLoading() => const Center(
                    child: CircularProgressIndicator(),
                  ),

                SearchEmpty() => const Center(
                    child: Text(
                      'No products found matching your search',
                    ),
                  ),

                SearchError() => const Center(
                    child: Text('Something went wrong while searching'),
                  ),

                SearchSuccess() => GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 0.65,
                    ),
                    itemCount: state.products.length,
                    itemBuilder: (context, index) {
                      final product = state.products[index];

                      return ProductItemCard(
                        item: product,
                        isFavorite: false,
                        onFavoriteTap: () {},
                        onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                           builder: (_) => BlocProvider.value(
                            value: serviceLocator<CartCubit>(),
                            child: ProductDetailsScreen(
                            product: product,
                           ),
                         ),
                       ),
                      );
                    },
                   );
                  },
                 ),
              };
            },
          ),
        ),
      ],
    );
  }
}