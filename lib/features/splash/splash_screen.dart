import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/theme/app_colors.dart';
import 'widgets/splash_button.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static const _heroAsset = 'assets/images/workora_hero.png';

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _tryResumeSession());
  }

  /// Supabase sessiyasi saqlangan bo‘lsa (oldingi kirish), login qayta so‘ralmaydi.
  Future<void> _tryResumeSession() async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    if (!Supabase.instance.isInitialized) return;

    final session = Supabase.instance.client.auth.currentSession;
    if (session != null) {
      if (!mounted) return;
      context.go('/app');
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      backgroundColor: AppColors.splashBackground,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 90,
              left: 0,
              right: 0,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      SplashScreen._heroAsset,
                      width: width * 0.95,
                      fit: BoxFit.contain,
                      filterQuality: FilterQuality.high,
                    ),
                  ),
                  const SizedBox(height: 45),
                  const Text(
                    'Workora',
                    style: TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      letterSpacing: -1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'AI yordamida ish toping',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withValues(alpha: 0.8),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              left: 24,
              right: 24,
              bottom: 20,
              child: SplashButton(onTap: () => context.go('/login')),
            ),
          ],
        ),
      ),
    );
  }
}
