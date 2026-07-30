import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_graduation/core/constants/app_keys.dart';
import 'package:project_graduation/core/constants/app_routes.dart';
import 'package:project_graduation/core/di/service_locator.dart';
import 'package:project_graduation/core/storage_helper/local_storage_service.dart';
import 'package:project_graduation/core/storage_helper/secure_storage_helper.dart';
import 'package:project_graduation/core/theme/app_theme.dart';
import 'package:project_graduation/core/utils/my_bloc_observer.dart';

//RequestRester
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  Bloc.observer = MyBlocObserver();
  String? token = await SecureStorageHelper.instance.getSecure(key: AppKeys.token);

  final isFirstTime = await LocalStorageService.isFirstTime();

  runApp(MyApp(isFirstTime: isFirstTime, token: token));
}

class MyApp extends StatelessWidget {
  final bool isFirstTime;
  final String? token;
  const MyApp({
    super.key,
    required this.isFirstTime,
    this.token,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Graduation Project',
      theme: AppTheme.lightTheme,
      initialRoute: token != null
          ? AppRoutes.appSection
          : isFirstTime
              ? AppRoutes.onboarding
              : AppRoutes.hello,
      routes: AppRoutes.routes,
    );
  }
}
