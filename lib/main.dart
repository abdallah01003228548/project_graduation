import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_graduation/core/constants/app_routes.dart';
import 'package:project_graduation/core/di/service_locator.dart';
import 'package:project_graduation/core/storage_helper/local_storage_service.dart';
import 'package:project_graduation/core/theme/app_theme.dart';
import 'package:project_graduation/core/utils/my_bloc_observer.dart';

//RequestRester
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  Bloc.observer = MyBlocObserver();
  // Save the token to local storage for testing 
  // when the login feature is implemented, this line should be removed
  await LocalStorageService.saveToken('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjZhNjVjOTFhYTMzZDNkYjFjNjdlYmUzYyIsImlhdCI6MTc4NTA1NTUzMywiZXhwIjoxNzg3NjQ3NTMzfQ.tXY2iBqR-8n24KL9qzrDhEmhaktC91Rv6Tr4YYQjWFw');
  await LocalStorageService.getToken();
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
      theme: AppTheme.lightTheme,
      initialRoute:
          isFirstTime ? AppRoutes.onboarding : AppRoutes.hello,
      routes: AppRoutes.routes,
    );
  }
}
