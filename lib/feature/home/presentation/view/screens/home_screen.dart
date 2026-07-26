import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_graduation/core/di/service_locator.dart';
import 'package:project_graduation/core/model/widget/product_item_card.dart';
import 'package:project_graduation/core/theme/app_colors.dart';
import 'package:project_graduation/core/theme/app_dimens.dart';
import 'package:project_graduation/core/theme/app_spacing.dart';
import 'package:project_graduation/core/theme/app_text_styles.dart';
import 'package:project_graduation/feature/home/presentation/view_model/home/home_cubit.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Set<String> _favoriteIds = {};
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => serviceLocator<HomeCubit>()..getHomeData(),
      child: Scaffold(
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
              onPressed: () {},
            ),
          ],
        ),
        body: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is HomeError) {
              return Center(child: Text(state.messageError));
            }
            if (state is HomeSuccess) {
              return Padding(
                padding: AppSpacing.screenHorizontal,
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: AppSpacing.base2x,
                    runSpacing: AppSpacing.base3x,
              children: state.products.map((item) {
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
          ),
        );
            }
            return const SizedBox.shrink();
          },
       ),
      ),
    );
  }
}
