import 'package:flutter/material.dart';
import 'package:project_graduation/core/theme/app_text_styles.dart';

class HomeGreetingHeader extends StatelessWidget {
  final String userName;

  const HomeGreetingHeader({super.key, this.userName = ''});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hi There!!,', style: Theme.of(context).textTheme.bodyMedium),
        const SizedBox(height: 4),
        const Text("Let's Start Your Day", style: AppTextStyles.h2Heading),
      ],
    );
  }
}