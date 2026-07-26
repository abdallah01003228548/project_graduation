import 'package:flutter/material.dart';
import 'package:project_graduation/feature/app_section/view/app_section_screen.dart';

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

  const MyApp({
    super.key,
    required this.isFirstTime,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: AppSectionScreen(),
    );
  }
}
