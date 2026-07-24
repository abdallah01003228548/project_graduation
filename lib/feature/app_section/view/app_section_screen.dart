import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_graduation/feature/account/presentation/view/screens/account_screen.dart';
import 'package:project_graduation/feature/app_section/view_model/app_section_cubit.dart';
import 'package:project_graduation/feature/app_section/view_model/app_section_state.dart';
import 'package:project_graduation/feature/cart/presentation/view/screens/cart_screen.dart';
import 'package:project_graduation/feature/favourite/presentation/view/screens/favourite_screen.dart';
import 'package:project_graduation/feature/home/presentation/view/screens/home_screen.dart';
import 'package:project_graduation/core/theme/app_colors.dart';

class AppSectionScreen extends StatelessWidget {
  const AppSectionScreen({super.key});

  static const List<Widget> _screens = [
    HomeScreen(),
    CartScreen(),
    FavouriteScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppSectionCubit(),
      child: BlocBuilder<AppSectionCubit, AppSectionState>(
        builder: (context, state) {
          return Scaffold(
            body: _screens[state.currentIndex],
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: state.currentIndex,
              selectedItemColor: AppColors.orangeLight,
              unselectedItemColor: const Color(0xFF5C5C5C),
              onTap: (index) {
                context.read<AppSectionCubit>().changeIndex(index);
              },
              type: BottomNavigationBarType.fixed,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/Home.svg',
                    colorFilter: ColorFilter.mode(
                      state.currentIndex == 0
                          ? AppColors.orangeLight
                          : const Color(0xFF5C5C5C),
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/cart.svg',
                    colorFilter: ColorFilter.mode(
                      state.currentIndex == 1
                          ? AppColors.orangeLight
                          : const Color(0xFF5C5C5C),
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'Cart',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/favourite.svg',
                    colorFilter: ColorFilter.mode(
                      state.currentIndex == 2
                          ? AppColors.orangeLight
                          : const Color(0xFF5C5C5C),
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'Favourite',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/icons/Group.svg',
                    colorFilter: ColorFilter.mode(
                      state.currentIndex == 3
                          ? AppColors.orangeLight
                          : const Color(0xFF5C5C5C),
                      BlendMode.srcIn,
                    ),
                  ),
                  label: 'Account',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
