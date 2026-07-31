import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_graduation/core/di/service_locator.dart';
import 'package:project_graduation/core/theme/app_colors.dart';
import 'package:project_graduation/core/theme/app_spacing.dart';
import 'package:project_graduation/feature/home/domain/entities/category_entity.dart';
import 'package:project_graduation/feature/home/presentation/view/widget/home_category_tabs_widget.dart';
import 'package:project_graduation/feature/home/presentation/view/widget/home_greeting_widget.dart';
import 'package:project_graduation/feature/home/presentation/view/widget/home_product_grid_widget.dart';
import 'package:project_graduation/feature/home/presentation/view_model/home/home_cubit.dart';
import 'package:project_graduation/feature/favourite/presentation/view_model/favourite_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<HomeCubit>()..getHomeData(),
      child: Scaffold(
        backgroundColor: AppColors.background,
        body: SafeArea(
          child: BlocBuilder<HomeCubit, HomeState>(
            builder: (context, state) {
              if (state is HomeLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is HomeError) {
                return Center(child: Text(state.messageError));
              }
              if (state is HomeSuccess) {
                return _buildContent(state);
              }
              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  Widget _buildContent(HomeSuccess state) {
    final categoryNames = <CategoryEntity>[
      CategoryEntity(name: 'All', slug: '', image: ''),
      ...state.categories
          .map((c) => c is CategoryEntity
          ? c as CategoryEntity
          : CategoryEntity(name: c.toString(), slug: '', image: ''))
          .toList(),
    ];
    final selectedCategory = categoryNames.any(
          (category) => category.name == _selectedCategory,
    )
        ? _selectedCategory
        : 'All';
    final filteredProducts = selectedCategory == 'All'
        ? state.products
        : state.products
        .where((product) => product.category == selectedCategory)
        .toList();

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: AppSpacing.screenHorizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                const HomeGreetingHeader(),
                const SizedBox(height: 20),
                HomeCategoryTabs(
                  categories: categoryNames,
                  selectedCategory: selectedCategory,
                  onCategorySelected: (category) {
                    setState(() {
                      _selectedCategory = category.name;
                    });
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        BlocConsumer<FavouriteCubit, FavouriteState>(
          listener: (context, favState) {
            if (favState is FavouriteError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(favState.messageError)),
              );
            }
          },
          builder: (context, favState) {
            final cubit = context.read<FavouriteCubit>();

            return HomeProductGrid(
              products: filteredProducts,
              favoriteIds: cubit.favouriteIds,
              onFavoriteTap: (product) async {
                final result = await cubit.toggleFavourite(product);

                if (context.mounted && result != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        result
                            ? 'Added to favourites'
                            : 'Removed from favourites',
                      ),
                    ),
                  );
                }
              },
            );
          },
        ),
      ],
    );
  }
}