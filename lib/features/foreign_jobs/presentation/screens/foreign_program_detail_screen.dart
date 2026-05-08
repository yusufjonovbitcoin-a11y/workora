import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_button.dart';

class ForeignProgramDetailScreen extends StatelessWidget {
  const ForeignProgramDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Program Detail')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Seasonal Work Program',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            const Text('Program requirements and benefits will appear here.'),
            const Spacer(),
            AppButton(
              text: 'Apply',
              onPressed: () {
                context.go('/foreign-application');
              },
            ),
          ],
        ),
      ),
    );
  }
}
