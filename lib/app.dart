import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

class WorkoraApp extends StatelessWidget {
  const WorkoraApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (ctx, _) {
        return MaterialApp.router(
          title: 'Workora',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme(ctx),
          darkTheme: AppTheme.darkTheme(ctx),
          themeMode: ThemeMode.system,
          routerConfig: AppRouter.router,
        );
      },
    );
  }
}
