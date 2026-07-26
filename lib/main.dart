import 'package:flutter/material.dart';
import 'package:project_graduation/core/constants/app_routes.dart';
import 'package:project_graduation/core/storage_helper/local_storage_service.dart';
import 'package:project_graduation/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final isFirstTime = await LocalStorageService.isFirstTime();

  runApp(MyApp(isFirstTime: isFirstTime));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;

  const MyApp({
    super.key,
    required this.isFirstTime,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Graduation Project',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      initialRoute:
          isFirstTime ? AppRoutes.onboarding : AppRoutes.hello,
      routes: AppRoutes.routes,
    );
  }
}