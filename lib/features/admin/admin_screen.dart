import 'package:flutter/material.dart';

import '../../core/theme/app_colors.dart';
import 'analytics/analytics_screen.dart';
import 'applications/applications_screen.dart';
import 'data/admin_mock_data.dart';
import 'messages/admin_messages_screen.dart';
import 'models/admin_message_model.dart';
import 'models/admin_user_model.dart';
import 'models/admin_vacancy_model.dart';
import 'models/application_model.dart';
import 'settings/admin_settings_screen.dart';
import 'users/users_screen.dart';
import 'vacancies/add_foreign_job_screen.dart';
import 'vacancies/vacancies_admin_screen.dart';
import 'widgets/admin_sidebar.dart';
import 'widgets/dashboard_overview.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({super.key});

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int selectedIndex = 0;
  late List<AdminUserModel> users = [...AdminMockData.users];
  late List<AdminVacancyModel> vacancies = [...AdminMockData.vacancies];
  late List<ApplicationModel> applications = [...AdminMockData.applications];
  late List<AdminMessageModel> messages = [...AdminMockData.messages];

  @override
  Widget build(BuildContext context) {
    final desktop = MediaQuery.of(context).size.width >= 900;

    return Scaffold(
      backgroundColor: const Color(0xFFF7F9FC),
      drawer: desktop
          ? null
          : Drawer(
              child: AdminSidebar(
                selectedIndex: selectedIndex,
                onChanged: (value) {
                  Navigator.pop(context);
                  setState(() => selectedIndex = value);
                },
              ),
            ),
      body: Row(
        children: [
          if (desktop)
            AdminSidebar(
              selectedIndex: selectedIndex,
              onChanged: (value) => setState(() => selectedIndex = value),
            ),
          Expanded(
            child: Builder(
              builder: (context) {
                return Column(
                  children: [
                    _AdminTopBar(
                      showMenu: !desktop,
                      onMenu: () => Scaffold.of(context).openDrawer(),
                    ),
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.fromLTRB(36, 28, 36, 36),
                        children: [_buildContent()],
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContent() {
    return switch (selectedIndex) {
      0 => const _DashboardPage(),
      1 => UsersScreen(
        users: users,
        onUpdateUser: (user) {
          setState(() {
            users = [
              for (final item in users) item.id == user.id ? user : item,
            ];
          });
        },
      ),
      2 => VacanciesAdminScreen(
        vacancies: vacancies.where((item) => !item.isForeign).toList(),
        onUpdate: updateVacancy,
        onDelete: deleteVacancy,
        onAdd: addVacancy,
      ),
      3 => AddForeignJobScreen(
        vacancies: vacancies.where((item) => item.isForeign).toList(),
        onAdd: addVacancy,
        onUpdate: updateVacancy,
        onDelete: deleteVacancy,
      ),
      4 => ApplicationsScreen(
        applications: applications,
        onStatusChanged: (application, status) {
          setState(() {
            applications = [
              for (final item in applications)
                item.id == application.id
                    ? item.copyWith(status: status)
                    : item,
            ];
          });
        },
      ),
      5 => AdminMessagesScreen(
        conversations: messages,
        onChanged: (items) => setState(() => messages = items),
      ),
      6 => const AnalyticsScreen(),
      7 => const AdminSettingsScreen(),
      _ => const SizedBox.shrink(),
    };
  }

  void addVacancy(AdminVacancyModel vacancy) {
    setState(() => vacancies = [vacancy, ...vacancies]);
  }

  void updateVacancy(AdminVacancyModel vacancy) {
    setState(() {
      vacancies = [
        for (final item in vacancies) item.id == vacancy.id ? vacancy : item,
      ];
    });
  }

  void deleteVacancy(AdminVacancyModel vacancy) {
    setState(() => vacancies.removeWhere((item) => item.id == vacancy.id));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        backgroundColor: AppColors.primary,
        content: Text('Vakansiya o‘chirildi'),
      ),
    );
  }
}

class _DashboardPage extends StatelessWidget {
  const _DashboardPage();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Xush kelibsiz, Admin!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w900,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Bugungi statistik ma’lumotlar va platforma holati',
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFE7EAF0)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: .035),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.calendar_month_rounded, color: AppColors.primary),
                  SizedBox(width: 10),
                  Text(
                    'Bugun: 18 may, 2025',
                    style: TextStyle(fontWeight: FontWeight.w900),
                  ),
                  SizedBox(width: 10),
                  Icon(Icons.keyboard_arrow_down_rounded),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 26),
        const DashboardOverview(),
      ],
    );
  }
}

class _AdminTopBar extends StatelessWidget {
  const _AdminTopBar({required this.showMenu, required this.onMenu});

  final bool showMenu;
  final VoidCallback onMenu;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 92,
      padding: const EdgeInsets.symmetric(horizontal: 36),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: .96),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: .06),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Row(
        children: [
          IconButton(
            onPressed: showMenu ? onMenu : () {},
            icon: const Icon(Icons.menu_rounded, size: 26),
          ),
          const SizedBox(width: 18),
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 430),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Qidirish...',
                prefixIcon: const Icon(Icons.search_rounded),
                suffixIcon: Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    border: Border.all(color: const Color(0xFFE7EAF0)),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text(
                    'Ctrl + K',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w800),
                  ),
                ),
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 74,
                  maxWidth: 80,
                ),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(vertical: 16),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFFE7EAF0)),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: Color(0xFFE7EAF0)),
                ),
              ),
            ),
          ),
          const Spacer(),
          Stack(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.notifications_none_rounded, size: 28),
              ),
              Positioned(
                top: 8,
                right: 7,
                child: Container(
                  padding: const EdgeInsets.all(5),
                  decoration: const BoxDecoration(
                    color: AppColors.primary,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '5',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 24),
          const CircleAvatar(
            radius: 24,
            backgroundImage: NetworkImage(
              'https://images.unsplash.com/photo-1500648767791-00dcc994a43e',
            ),
          ),
          const SizedBox(width: 14),
          const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Admin',
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w900,
                ),
              ),
              SizedBox(height: 3),
              Text(
                'Administrator',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
          const SizedBox(width: 10),
          const Icon(Icons.keyboard_arrow_down_rounded),
        ],
      ),
    );
  }
}
