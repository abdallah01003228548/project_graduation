import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_graduation/core/model/widget/product_item_card.dart';
import 'package:project_graduation/feature/favourite/presentation/view_model/favourite_cubit.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FavouriteView();
  }
}

class FavouriteView extends StatelessWidget {
  const FavouriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Favourite'),
        centerTitle: true,
        leading: const BackButton(),
      ),
      body: BlocConsumer<FavouriteCubit, FavouriteState>(
        listener: (context, state) {
          if (state is FavouriteError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.messageError)),
            );
          }
        },
        builder: (context, state) {
          if (state is FavouriteLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is FavouriteError) {
            return Center(child: Text(state.messageError));
          }

          if (state is FavouriteSuccess) {
            final products = state.favourite.products;

            if (products.isEmpty) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/favourite.svg',
                      width: 120,
                      height: 120,
                      colorFilter: const ColorFilter.mode(
                        Colors.black,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'There are no products in your\nfavourite list',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              );
            }

            return GridView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: .62,
              ),
              itemBuilder: (context, index) {
                final product = products[index];

                return ProductItemCard(
                  item: product,
                  isFavorite: true,
                  onFavoriteTap: () async {
                    final cubit = context.read<FavouriteCubit>();
                    final result = await cubit.toggleFavourite(product);

                    if (result == false && context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Removed from favourites'),
                        ),
                      );
                    }
                  },
                );
              },
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}