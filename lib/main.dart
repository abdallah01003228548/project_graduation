import 'package:flutter/material.dart';
import 'package:project_graduation/core/constants/app_routes.dart';
import 'package:project_graduation/core/di/service_locator.dart';
import 'package:project_graduation/core/storage_helper/local_storage_service.dart';
import 'package:project_graduation/core/theme/app_theme.dart';
import 'package:project_graduation/feature/home/presentation/view/screens/home_screen.dart';
import 'package:project_graduation/feature/onboarding/presentation/view/onboarding_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Save the token to local storage for testing 
  // when the login feature is implemented, this line should be removed
  await LocalStorageService.saveToken('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhNjVjOTFhYTMzZDNkYjFjNjdlYmUzYyIsImlhdCI6MTc4NTA1NTUzMywiZXhwIjoxNzg3NjQ3NTMzfQ.tXY2iBqR-8n24KL9qzrDhEmhaktC91Rv6Tr4YYQjWFw');
  await LocalStorageService.getToken();
  configureDependencies();
  final isFirstTime = await LocalStorageService.isFirstTime();

  runApp(MyApp(isFirstTime: isFirstTime));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;

  const MyApp({super.key, required this.isFirstTime});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme,
      initialRoute: isFirstTime ? AppRoutes.onboarding : AppRoutes.login,
      routes: {
        AppRoutes.onboarding: (context) => const OnboardingScreen(),
        AppRoutes.login: (context) => const _PlaceholderScreen(title: 'Login Screen'),
        AppRoutes.register: (context) => const _PlaceholderScreen(title: 'Register Screen'),
        AppRoutes.homeScreen: (context) => const HomeScreen(),
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
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(title),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.homeScreen);
              },
              child: const Text('Go to Home Screen'),
            ),
          ],
        ),
      ),
    );
  }
}