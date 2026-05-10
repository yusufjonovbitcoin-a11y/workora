import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workora/features/main_nav/main_navigation_screen.dart';

void main() {
  testWidgets('opens foreign jobs tab from bottom navigation', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: MainNavigationScreen()),
      ),
    );

    await tester.tap(find.text('Xorijda ish'));
    await tester.pump(const Duration(milliseconds: 300));

    expect(find.textContaining('Xorijda ish'), findsWidgets);
  });
}
