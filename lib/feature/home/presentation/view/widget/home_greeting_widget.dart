import 'package:flutter/material.dart';
import 'package:project_graduation/core/theme/app_text_styles.dart';

class HomeGreetingHeader extends StatelessWidget {
  final String userName;
  final VoidCallback? onSearchPressed;

  const HomeGreetingHeader({
    super.key,
    this.userName = '',
    this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Hi There!!,', style: Theme.of(context).textTheme.bodyMedium),
              const SizedBox(height: 4),
              const Text("Let's Start Your Day", style: AppTextStyles.h2Heading),
            ],
          ),
        ),
        IconButton(
          tooltip: 'Search products',
          onPressed: onSearchPressed,
          icon: const Icon(Icons.search_rounded),
        ),
      ],
    );
  }
}
