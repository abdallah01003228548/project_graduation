import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_graduation/feature/products_by_category/presentation/view/products_by_category_screen.dart';
import 'package:project_graduation/core/di/service_locator.dart'; // adjust to your actual serviceLocator import
import 'package:project_graduation/core/theme/app_colors.dart';
import 'package:project_graduation/core/theme/app_spacing.dart';
import 'package:project_graduation/feature/home/presentation/view/widget/home_category_tabs_widget.dart';
import 'package:project_graduation/feature/home/presentation/view/widget/home_greeting_widget.dart';
import 'package:project_graduation/feature/home/presentation/view/widget/home_product_grid_widget.dart';
import 'package:project_graduation/feature/home/presentation/view_model/home/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Set<String> _favoriteIds = {};
  String? _selectedCategory;

  void _toggleFavorite(String productId) {
    setState(() {
      if (_favoriteIds.contains(productId)) {
        _favoriteIds.remove(productId);
      } else {
        _favoriteIds.add(productId);
      }
    });
  }

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
    _selectedCategory ??=
    state.categories.isNotEmpty ? state.categories.first.name : null;

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
                  categories: state.categories,
                  selectedCategory: _selectedCategory ?? '',
                  onCategorySelected: (category) {
                    setState(() {
                      _selectedCategory = category.name;
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ProductsByCategoryScreen(
                          slug: category.slug,
                          categoryName: category.name,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
        HomeProductGrid(
          products: state.products,
          favoriteIds: _favoriteIds,
          onFavoriteTap: _toggleFavorite,
        ),
      ],
    );
  }
}