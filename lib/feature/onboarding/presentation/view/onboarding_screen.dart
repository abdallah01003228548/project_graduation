import 'package:flutter/material.dart';
import 'package:project_graduation/core/constants/app_assets.dart';
import 'package:project_graduation/core/constants/app_routes.dart';
import 'package:project_graduation/core/theme/app_colors.dart';
import 'package:project_graduation/core/theme/app_spacing.dart';
import 'package:project_graduation/core/theme/app_text_styles.dart';
import 'package:project_graduation/core/widget/custom_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  final _pages = [
    _OnboardingPage(
      image: AppAssets.onboarding1,
      title: 'Discover Trends',
      subtitle: 'Now we are here to provide variety of the best fashion',
    ),
    _OnboardingPage(
      image: AppAssets.onboarding2,
      title: 'Latest outfit',
      subtitle: 'Express your self through the art of the fashionism',
    ),
  ];

  bool get _isLastPage => _currentPage == _pages.length - 1;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_isLastPage) {
      _goToLogin();
      return;
    }

    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _goToLogin() {
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGray,
      body: SafeArea(
        child: Column(
          children: [
            _buildTopBar(),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) => setState(() => _currentPage = index),
                itemBuilder: (context, index) => _buildPage(_pages[index]),
              ),
            ),

          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSpacing.base2x,
        vertical: AppSpacing.base1x,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _currentPage > 0
              ? IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: _previousPage,
          )
              : const SizedBox(width: 48),
          _isLastPage
              ? const SizedBox(width: 48)
              : TextButton(
            onPressed: _goToLogin,
            child: Text(
              'Skip',
              style: AppTextStyles.bodyLarge.copyWith(
                color: AppColors.charcoal,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(_OnboardingPage page) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSpacing.base3x),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: AppSpacing.base1x),
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              height: 380,
              width: double.infinity,
              child: Image.asset(
                page.image,
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
          ),
          const SizedBox(height: 16),
          _buildDots(),
          const SizedBox(height: 64),
          Text(
            page.title,
            textAlign: TextAlign.center,
            style: AppTextStyles.h2Heading.copyWith(
              color: AppColors.charcoal,
              fontSize: 26,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 70),
            child: Text(
              page.subtitle,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.charcoal.withOpacity(0.75),
                fontSize: 20,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 64),

          CustomButton(
            text: _isLastPage ? 'Get started' : 'Next',
            onPressed: _nextPage,
            height: 58,
            fontSize: 17,
          ),
        ],
      ),
    );
  }

  Widget _buildDots() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(_pages.length, (index) {
        final isActive = _currentPage == index;
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 3),
          width: 15,
          height: 15,
          decoration: BoxDecoration(
            color: isActive ? AppColors.charcoal : AppColors.charcoal.withOpacity(0.25),
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}

class _OnboardingPage {
  final String image;
  final String title;
  final String subtitle;

  _OnboardingPage({
    required this.image,
    required this.title,
    required this.subtitle,
  });
}