import 'package:flutter/material.dart';

/// Bitta manba: [ThemeData.textTheme] (Inter, super-app ga yaqin scale).
///
/// | Token | O‘lcham | Qo‘llanishi |
/// |-------|---------|-------------|
/// | appBarTitle | 18.sp / w600 | AppBar, yirik sarlavha |
/// | sectionTitle | 16.sp / w600 | Bo‘lim sarlavhalari |
/// | cardTitle | 15.sp / w600 | kartochka / ro‘yxat sarlavhasi |
/// | body | 15.sp / w400 | asosiy matn |
/// | caption | 13.sp / w400 | ikkinchi darajali, meta |
/// | navLabel | 11.sp / w500 | pastki nav, kichik yorliq |
abstract final class AppTypography {
  static TextStyle appBarTitle(BuildContext context) =>
      Theme.of(context).textTheme.titleLarge!;

  static TextStyle sectionTitle(BuildContext context) =>
      Theme.of(context).textTheme.titleMedium!;

  static TextStyle cardTitle(BuildContext context) =>
      Theme.of(context).textTheme.titleSmall!;

  static TextStyle body(BuildContext context) =>
      Theme.of(context).textTheme.bodyMedium!;

  static TextStyle caption(BuildContext context) =>
      Theme.of(context).textTheme.bodySmall!;

  static TextStyle navLabel(BuildContext context) =>
      Theme.of(context).textTheme.labelSmall!;
}
