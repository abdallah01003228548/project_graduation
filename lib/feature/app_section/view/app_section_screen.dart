import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_graduation/core/di/service_locator.dart';
import 'package:project_graduation/core/theme/app_colors.dart';
import 'package:project_graduation/feature/account/presentation/view/screens/account_screen.dart';
import 'package:project_graduation/feature/account/presentation/view_model/account_cubit.dart';
import 'package:project_graduation/feature/app_section/view_model/app_section_cubit.dart';
import 'package:project_graduation/feature/app_section/view_model/app_section_state.dart';
import 'package:project_graduation/feature/cart/presentation/view/screen/cart_screen.dart';
import 'package:project_graduation/feature/cart/presentation/view_model/cart/cart_cubit.dart';
import 'package:project_graduation/feature/favourite/presentation/view/screens/favourite_screen.dart';
import 'package:project_graduation/feature/favourite/presentation/view_model/favourite_cubit.dart';
import 'package:project_graduation/feature/home/presentation/view/screens/home_screen.dart';

class AppSectionScreen extends StatelessWidget {
  const AppSectionScreen({super.key});

  static const List<Widget> _screens = [
    HomeScreen(),
    CartScreen(),
    FavouriteScreen(),
    AccountScreen(),
  ];

  static const List<String> _iconPaths = [
    'assets/icons/Home.svg',
    'assets/icons/cart.svg',
    'assets/icons/favourite.svg',
    'assets/icons/account.svg',
  ];

  static const List<String> _labels = [
    'Home',
    'Cart',
    'Favourite',
    'Account',
  ];

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AppSectionCubit>(
          create: (_) => AppSectionCubit(),
        ),

        BlocProvider<CartCubit>(
          create: (_) => serviceLocator<CartCubit>(),
        ),

        BlocProvider<AccountCubit>(
          create: (_) => serviceLocator<AccountCubit>(),
        ),

        BlocProvider<FavouriteCubit>(
          create: (_) =>
              serviceLocator<FavouriteCubit>()..getFavouriteProducts(),
        ),
      ],
      child: BlocBuilder<AppSectionCubit, AppSectionState>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
              index: state.currentIndex,
              children: _screens,
            ),

            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.currentIndex,
              selectedItemColor: AppColors.orangeLight,
              unselectedItemColor: AppColors.charcoal,
              type: BottomNavigationBarType.fixed,

              onTap: (index) {
                context.read<AppSectionCubit>().changeIndex(index);

                // Cart tab
                if (index == 1) {
                  context.read<CartCubit>().getCart();
                }

                // Favourite tab
                if (index == 2) {
                  context
                      .read<FavouriteCubit>()
                      .getFavouriteProducts();
                }
              },

              items: List.generate(
                _screens.length,
                (index) {
                  final isSelected =
                      state.currentIndex == index;

                  return BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      _iconPaths[index],
                      colorFilter: ColorFilter.mode(
                        isSelected
                            ? AppColors.orangeLight
                            : AppColors.charcoal,
                        BlendMode.srcIn,
                      ),
                    ),
                    label: _labels[index],
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}