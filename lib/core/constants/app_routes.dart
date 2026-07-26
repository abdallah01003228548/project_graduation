import 'package:flutter/material.dart';

import 'package:project_graduation/feature/onboarding/presentation/view/onboarding_screen.dart';
import 'package:project_graduation/feature/hello/presentation/screens/hello_screen.dart';
import 'package:project_graduation/feature/auth/presentation/screens/login_screen.dart';
import 'package:project_graduation/feature/auth/presentation/screens/register_screen.dart';
import 'package:project_graduation/feature/app_section/view/app_section_screen.dart';
class AppRoutes {
  AppRoutes._();

  static const String onboarding = '/onboarding';
  static const String hello = '/hello';
  static const String login = '/login';
  static const String register = '/register';
  static const String appSection = '/app-section';

  static final Map<String, WidgetBuilder> routes = {
    onboarding: (_) => const OnboardingScreen(),
    hello: (_) => const HelloScreen(),
    login: (_) => const LoginScreen(),
    register: (_) => const RegisterScreen(),
    appSection: (_) => const AppSectionScreen(),
  };
}