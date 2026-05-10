import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../home/presentation/providers/home_provider.dart';
import '../home/presentation/widgets/home_job_card.dart';

class SavedJobsScreen extends ConsumerWidget {
  const SavedJobsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        elevation: 0,
        title: const Text('Saqlangan ishlar'),
      ),
      body: homeState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => Center(
          child: TextButton(
            onPressed: () => ref.invalidate(homeProvider),
            child: const Text('Qayta yuklash'),
          ),
        ),
        data: (state) => ListView(
          padding: const EdgeInsets.fromLTRB(18, 10, 18, 24),
          children: [
            const Text(
              'Siz keyin ko‘rish uchun saqlagan vakansiyalar',
              style: TextStyle(
                color: Color(0xFF667085),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 18),
            for (final job in state.jobs)
              HomeJobCard(
                job: job,
                onTap: () => context.push('/vacancy-detail/${job.id}'),
              ),
          ],
        ),
      ),
    );
  }
}
