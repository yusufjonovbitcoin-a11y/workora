import 'package:go_router/go_router.dart';

import '../../features/admin/admin_screen.dart';
import '../../features/admin/analytics/analytics_screen.dart';
import '../../features/admin/applications/applications_screen.dart';
import '../../features/admin/data/admin_mock_data.dart';
import '../../features/admin/messages/admin_messages_screen.dart';
import '../../features/admin/settings/admin_settings_screen.dart';
import '../../features/admin/users/users_screen.dart';
import '../../features/admin/vacancies/add_foreign_job_screen.dart';
import '../../features/admin/vacancies/vacancies_admin_screen.dart';
import '../../features/auth/login_screen.dart';
import '../../features/auth/otp_screen.dart';
import '../../features/auth/register_screen.dart';
import '../../features/foreign_jobs/presentation/screens/foreign_application_screen.dart';
import '../../features/main_nav/main_navigation_screen.dart';
import '../../features/messages/chat_detail_screen.dart';
import '../../features/profile/applied_jobs_screen.dart';
import '../../features/profile/edit_profile_screen.dart';
import '../../features/profile/notifications_screen.dart';
import '../../features/profile/saved_jobs_screen.dart';
import '../../features/profile/settings_screen.dart';
import '../../features/splash/splash_screen.dart';
import '../../features/super_admin/super_admin_screen.dart';
import '../../features/vacancy/apply_job_screen.dart';
import '../../features/vacancy/vacancy_detail_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/onboarding', redirect: (context, state) => '/login'),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(path: '/otp', builder: (context, state) => const OtpScreen()),
      GoRoute(
        path: '/app',
        builder: (context, state) => const MainNavigationScreen(),
      ),
      GoRoute(
        path: '/apply-job',
        builder: (context, state) => const ApplyJobScreen(),
      ),
      GoRoute(
        path: '/vacancy-detail',
        builder: (context, state) => const VacancyDetailScreen(),
      ),
      GoRoute(
        path: '/foreign-application',
        builder: (context, state) => const ForeignApplicationScreen(),
      ),
      GoRoute(
        path: '/saved-jobs',
        builder: (context, state) => const SavedJobsScreen(),
      ),
      GoRoute(
        path: '/edit-profile',
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: '/applied-jobs',
        builder: (context, state) => const AppliedJobsScreen(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/chat-detail',
        builder: (context, state) =>
            const ChatDetailScreen(name: 'Samsung Korea', avatar: 'S'),
      ),
      GoRoute(path: '/admin', builder: (context, state) => const AdminScreen()),
      GoRoute(
        path: '/admin/users',
        builder: (context, state) =>
            UsersScreen(users: AdminMockData.users, onUpdateUser: (_) {}),
      ),
      GoRoute(
        path: '/admin/vacancies',
        builder: (context, state) => VacanciesAdminScreen(
          vacancies: AdminMockData.vacancies,
          onUpdate: (_) {},
          onDelete: (_) {},
          onAdd: (_) {},
        ),
      ),
      GoRoute(
        path: '/admin/foreign-jobs',
        builder: (context, state) => AddForeignJobScreen(
          vacancies: AdminMockData.vacancies,
          onAdd: (_) {},
          onUpdate: (_) {},
          onDelete: (_) {},
        ),
      ),
      GoRoute(
        path: '/admin/applications',
        builder: (context, state) => ApplicationsScreen(
          applications: AdminMockData.applications,
          onStatusChanged: (_, _) {},
        ),
      ),
      GoRoute(
        path: '/admin/messages',
        builder: (context, state) => AdminMessagesScreen(
          conversations: AdminMockData.messages,
          onChanged: (_) {},
        ),
      ),
      GoRoute(
        path: '/admin/analytics',
        builder: (context, state) => const AnalyticsScreen(),
      ),
      GoRoute(
        path: '/admin/settings',
        builder: (context, state) => const AdminSettingsScreen(),
      ),
      GoRoute(
        path: '/super-admin',
        builder: (context, state) => const SuperAdminScreen(),
      ),
    ],
  );
}
