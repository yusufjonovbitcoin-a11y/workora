import 'package:flutter/material.dart';

import '../models/admin_user_model.dart';
import '../widgets/admin_header.dart';
import '../widgets/admin_search_bar.dart';
import '../widgets/admin_table.dart';
import '../widgets/status_chip.dart';
import 'user_detail_screen.dart';

class UsersScreen extends StatefulWidget {
  const UsersScreen({
    super.key,
    required this.users,
    required this.onUpdateUser,
  });

  final List<AdminUserModel> users;
  final ValueChanged<AdminUserModel> onUpdateUser;

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  String query = '';
  String filter = 'all';

  @override
  Widget build(BuildContext context) {
    final filtered = widget.users.where((user) {
      final matchesQuery =
          user.name.toLowerCase().contains(query.toLowerCase()) ||
          user.profession.toLowerCase().contains(query.toLowerCase());
      final matchesFilter =
          filter == 'all' ||
          (filter == 'active' && user.isActive) ||
          (filter == 'inactive' && !user.isActive) ||
          (filter == 'premium' && user.isPremium);
      return matchesQuery && matchesFilter;
    }).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AdminHeader(
          title: 'Foydalanuvchilar',
          subtitle: 'Userlar, statuslar va verifikatsiyani boshqarish',
        ),
        const SizedBox(height: 18),
        Row(
          children: [
            Expanded(
              child: AdminSearchBar(
                hint: 'User qidirish...',
                onChanged: (value) => setState(() => query = value),
              ),
            ),
            const SizedBox(width: 12),
            DropdownButton<String>(
              value: filter,
              items: const [
                DropdownMenuItem(value: 'all', child: Text('Barchasi')),
                DropdownMenuItem(value: 'active', child: Text('Active')),
                DropdownMenuItem(value: 'inactive', child: Text('Inactive')),
                DropdownMenuItem(value: 'premium', child: Text('Premium')),
              ],
              onChanged: (value) => setState(() => filter = value ?? 'all'),
            ),
          ],
        ),
        const SizedBox(height: 18),
        AdminTable(
          columns: const ['User', 'Kasb', 'Status', 'Badges', 'Action'],
          rows: [
            for (final user in filtered)
              [
                Text(user.name),
                Text(user.profession),
                StatusChip(status: user.isActive ? 'active' : 'inactive'),
                Text(
                  [
                    if (user.isVerified) 'Verified',
                    if (user.isPremium) 'Premium',
                  ].join(' • '),
                ),
                TextButton(
                  onPressed: () => openDetail(user),
                  child: const Text('Ochish'),
                ),
              ],
          ],
        ),
        const SizedBox(height: 18),
        Wrap(
          spacing: 14,
          runSpacing: 14,
          children: [
            for (final user in filtered)
              _UserCard(user: user, onTap: () => openDetail(user)),
          ],
        ),
      ],
    );
  }

  Future<void> openDetail(AdminUserModel user) async {
    final updated = await Navigator.of(context).push<AdminUserModel>(
      MaterialPageRoute(builder: (_) => UserDetailScreen(user: user)),
    );
    if (updated != null) widget.onUpdateUser(updated);
  }
}

class _UserCard extends StatelessWidget {
  const _UserCard({required this.user, required this.onTap});

  final AdminUserModel user;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: .04),
              blurRadius: 18,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          children: [
            CircleAvatar(backgroundImage: NetworkImage(user.imageUrl)),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.name,
                    style: const TextStyle(fontWeight: FontWeight.w900),
                  ),
                  const SizedBox(height: 4),
                  Text(user.profession, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
