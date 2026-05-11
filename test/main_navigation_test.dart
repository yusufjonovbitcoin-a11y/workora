import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:workora/features/main_nav/main_navigation_screen.dart';

void main() {
  testWidgets('bottom navigation shows core tabs', (tester) async {
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(home: MainNavigationScreen()),
      ),
    );

    expect(find.text('Bosh sahifa'), findsOneWidget);
    expect(find.text('AI Chat'), findsOneWidget);
    expect(find.text('Xabarlar'), findsOneWidget);
    expect(find.text('Profil'), findsOneWidget);
    expect(find.byIcon(Icons.add_rounded), findsOneWidget);
  });
}
