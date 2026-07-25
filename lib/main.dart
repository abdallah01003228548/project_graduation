import 'package:flutter/material.dart';
import 'package:project_graduation/feature/app_section/view/app_section_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const AppSectionScreen(),
      
    );
  }
}
