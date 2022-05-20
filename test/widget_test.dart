// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:lifegame/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const LifeGameApp());

    expect(find.text('Start'), findsOneWidget);
    expect(find.text('Stop'), findsNothing);

    await tester.tap(find.text('Start'));
    await tester.pump();

    expect(find.text('Start'), findsNothing);
    expect(find.text('Stop'), findsOneWidget);
  });
}
