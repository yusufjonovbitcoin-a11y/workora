import 'package:flutter/material.dart';

import '../../../core/theme/app_colors.dart';
import '../models/admin_user_model.dart';
import '../widgets/admin_action_button.dart';
import '../widgets/status_chip.dart';

class UserDetailScreen extends StatefulWidget {
  const UserDetailScreen({super.key, required this.user});

  final AdminUserModel user;

  @override
  State<UserDetailScreen> createState() => _UserDetailScreenState();
}

class _UserDetailScreenState extends State<UserDetailScreen> {
  late AdminUserModel user = widget.user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8FAFC),
        title: const Text('User detail'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, user),
            child: const Text('Saqlash'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(22),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: _card(),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 44,
                  backgroundImage: NetworkImage(user.imageUrl),
                ),
                const SizedBox(width: 18),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.name,
                        style: const TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(user.profession),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        children: [
                          StatusChip(
                            status: user.isActive ? 'active' : 'blocked',
                          ),
                          if (user.isVerified)
                            const StatusChip(status: 'approved'),
                          if (user.isPremium)
                            const StatusChip(status: 'Premium'),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          _InfoGrid(user: user),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.all(22),
            decoration: _card(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Skills',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    for (final skill in user.skills)
                      Chip(
                        label: Text(skill),
                        backgroundColor: const Color(0xFFEAF6EE),
                        side: BorderSide.none,
                      ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              AdminActionButton(
                label: user.isActive ? 'Block user' : 'Unblock user',
                icon: Icons.block_rounded,
                onTap: () => setState(
                  () => user = user.copyWith(isActive: !user.isActive),
                ),
              ),
              AdminActionButton(
                label: user.isVerified ? 'Verified' : 'Verify user',
                icon: Icons.verified_rounded,
                onTap: () => setState(
                  () => user = user.copyWith(isVerified: !user.isVerified),
                ),
                filled: false,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoGrid extends StatelessWidget {
  const _InfoGrid({required this.user});

  final AdminUserModel user;

  @override
  Widget build(BuildContext context) {
    final items = [
      ('Telefon', user.phone),
      ('Manzil', user.location),
      ('Applications', '${user.applications}'),
      ('Saved jobs', '${user.savedJobs}'),
      ('AI match', '${user.aiMatch}%'),
      ('CV', 'muhammadamin_cv.pdf'),
    ];

    return GridView.count(
      crossAxisCount: MediaQuery.of(context).size.width > 700 ? 3 : 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: 12,
      mainAxisSpacing: 12,
      childAspectRatio: 2.8,
      children: [
        for (final item in items)
          Container(
            padding: const EdgeInsets.all(16),
            decoration: _card(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.$1,
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
                const SizedBox(height: 6),
                Text(
                  item.$2,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.w900),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

BoxDecoration _card() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(26),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withValues(alpha: .04),
        blurRadius: 18,
        offset: const Offset(0, 10),
      ),
    ],
  );
}
