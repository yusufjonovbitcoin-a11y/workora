import 'package:go_router/go_router.dart';

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
      GoRoute(
        path: '/otp',
        builder: (context, state) {
          final phone = state.extra as String? ?? '';
          return OtpScreen(phone: phone);
        },
      ),
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
        builder: (context, state) =>
            const VacancyDetailScreen(vacancyId: 'mock-factory-worker'),
      ),
      GoRoute(
        path: '/vacancy-detail/:id',
        builder: (context, state) => VacancyDetailScreen(
          vacancyId: state.pathParameters['id'] ?? 'mock-factory-worker',
        ),
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
    ],
  );
}
