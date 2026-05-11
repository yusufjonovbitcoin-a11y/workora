import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Inter + super-app uslubidagi `.sp` scale (Uber / LinkedIn / Material feed ga yaqin).
/// [BuildContext] — [ScreenUtilInit] `builder`dan; [MediaQuery.textScaler] bilan
/// tizim shrift masshtabi saqlanadi (`minTextAdapt`).
class AppTheme {
  static ThemeData lightTheme(BuildContext context) {
    final onSurface = AppColors.textPrimary;
    final secondary = AppColors.textSecondary;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        secondary: AppColors.accent,
        onSecondary: Colors.white,
        surface: AppColors.background,
        onSurface: onSurface,
        outline: AppColors.border,
      ),
      splashFactory: InkSparkle.splashFactory,
      textTheme: _textTheme(onSurface, secondary),
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: false,
        backgroundColor: AppColors.background.withValues(alpha: 0.94),
        surfaceTintColor: Colors.transparent,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.2,
          height: 1.22,
          color: onSurface,
        ),
        iconTheme: IconThemeData(color: onSurface, size: 24.r),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: AppColors.card,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(color: Colors.black.withValues(alpha: 0.04)),
        ),
      ),
      dividerTheme: DividerThemeData(color: AppColors.border, thickness: 1),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        filled: true,
        fillColor: AppColors.card,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 10.h,
        ),
        hintStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: secondary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.2),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: Size(0, 40.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          textStyle: GoogleFonts.inter(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textStyle: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  static ThemeData darkTheme(BuildContext context) {
    final onSurface = AppColors.darkTextPrimary;
    final secondary = AppColors.darkTextSecondary;

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.darkBackground,
      colorScheme: ColorScheme.dark(
        primary: AppColors.primary,
        onPrimary: Colors.white,
        secondary: AppColors.accent,
        onSecondary: Colors.white,
        surface: AppColors.darkSurface,
        onSurface: onSurface,
        outline: AppColors.darkBorder,
      ),
      splashFactory: InkSparkle.splashFactory,
      textTheme: _textTheme(onSurface, secondary),
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0.5,
        centerTitle: false,
        backgroundColor: AppColors.darkBackground.withValues(alpha: 0.94),
        surfaceTintColor: Colors.transparent,
        titleTextStyle: GoogleFonts.inter(
          fontSize: 18.sp,
          fontWeight: FontWeight.w600,
          letterSpacing: -0.2,
          height: 1.22,
          color: onSurface,
        ),
        iconTheme: IconThemeData(color: onSurface, size: 24.r),
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        margin: EdgeInsets.zero,
        color: AppColors.darkSurface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
          side: BorderSide(color: Colors.white.withValues(alpha: 0.06)),
        ),
      ),
      dividerTheme: DividerThemeData(color: AppColors.darkBorder, thickness: 1),
      inputDecorationTheme: InputDecorationTheme(
        isDense: true,
        filled: true,
        fillColor: AppColors.darkSurface,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 10.h,
        ),
        hintStyle: GoogleFonts.inter(
          fontSize: 14.sp,
          fontWeight: FontWeight.w400,
          color: secondary,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.darkBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.darkBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: AppColors.primary, width: 1.2),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          minimumSize: Size(0, 40.h),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.r)),
          textStyle: GoogleFonts.inter(
            fontSize: 15.sp,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.1,
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          textStyle: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  static TextTheme _textTheme(Color onSurface, Color secondary) {
    return TextTheme(
      titleLarge: GoogleFonts.inter(
        fontSize: 18.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.2,
        height: 1.22,
        color: onSurface,
      ),
      titleMedium: GoogleFonts.inter(
        fontSize: 16.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.15,
        height: 1.28,
        color: onSurface,
      ),
      titleSmall: GoogleFonts.inter(
        fontSize: 15.sp,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.1,
        height: 1.3,
        color: onSurface,
      ),
      bodyMedium: GoogleFonts.inter(
        fontSize: 15.sp,
        fontWeight: FontWeight.w400,
        height: 1.45,
        letterSpacing: -0.05,
        color: onSurface,
      ),
      bodySmall: GoogleFonts.inter(
        fontSize: 13.sp,
        fontWeight: FontWeight.w400,
        height: 1.38,
        letterSpacing: 0,
        color: secondary,
      ),
      labelSmall: GoogleFonts.inter(
        fontSize: 11.sp,
        fontWeight: FontWeight.w500,
        height: 1.22,
        letterSpacing: 0.12,
        color: secondary,
      ),
    );
  }
}
