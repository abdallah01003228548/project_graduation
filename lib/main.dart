import 'package:flutter/material.dart';
import 'package:project_graduation/core/constants/app_routes.dart';
import 'package:project_graduation/core/storage_helper/local_storage_service.dart';
import 'package:project_graduation/core/theme/app_theme.dart';
import 'package:project_graduation/feature/onboarding/presentation/view/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isFirstTime = await LocalStorageService.isFirstTime();

  runApp(MyApp(isFirstTime: isFirstTime));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;

  const MyApp({super.key, required this.isFirstTime});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute: isFirstTime ? AppRoutes.onboarding : AppRoutes.login,
      routes: {
        AppRoutes.onboarding: (context) => const OnboardingScreen(),
        AppRoutes.login: (context) => const _PlaceholderScreen(title: 'Login Screen'),
        AppRoutes.register: (context) => const _PlaceholderScreen(title: 'Register Screen'),
      },
    );
  }
}

class _PlaceholderScreen extends StatelessWidget {
  final String title;

  const _PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(title)),
    );
  }
}