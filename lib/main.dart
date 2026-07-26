import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/routes.dart';
import 'feature/hello/presentation/screens/hello_screen.dart';
import 'feature/auth/presentation/screens/login_screen.dart';
import 'feature/auth/presentation/screens/register_screen.dart';
import 'package:project_graduation/core/constants/app_routes.dart';
import 'package:project_graduation/core/storage_helper/local_storage_service.dart';
import 'package:project_graduation/core/theme/app_theme.dart';
import 'package:project_graduation/feature/onboarding/presentation/view/onboarding_screen.dart';
import 'package:project_graduation/feature/app_section/view/app_section_screen.dart';

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
      title: 'Graduation Project',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,


      initialRoute: Routes.hello,
      routes: {
        Routes.hello: (context) =>  const HelloScreen(),
        Routes.login: (context) => const LoginScreen(),
        Routes.register: (context)  => const RegisterScreen(),
      },
    );
  }
}

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
