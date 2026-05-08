import 'package:flutter_test/flutter_test.dart';
import 'package:workora/app.dart';

void main() {
  testWidgets('shows splash screen', (WidgetTester tester) async {
    await tester.pumpWidget(const WorkoraApp());

    expect(find.text('Workora'), findsOneWidget);
    expect(find.text('Boshlash'), findsOneWidget);
  });
}
