import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:animal_puzzle_game/main.dart';

void main() {
  testWidgets('home page shows the available matching games',
      (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());

    expect(find.text('Choose a Matching Game'), findsOneWidget);
    expect(find.text('Animals Game'), findsOneWidget);
    expect(find.text('Fruits Game'), findsOneWidget);
    expect(find.text('Vegetables Game'), findsOneWidget);

    await tester.drag(find.byType(ListView), const Offset(0, -600));
    await tester.pumpAndSettle();

    expect(find.text('Professions Game'), findsOneWidget);
  });
}
