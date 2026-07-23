import 'package:flutter/material.dart';
import 'core/theme/app_theme.dart';
import 'core/constants/routes.dart';
import 'feature/hello/presentation/screens/hello_screen.dart';
import 'feature/auth/presentation/screens/login_screen.dart';
import 'feature/auth/presentation/screens/register_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

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

