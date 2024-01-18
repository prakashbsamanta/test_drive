import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_drive/main.dart';

void main() {
  group('Testing App', () {
    testWidgets('Integration test for the main app', (tester) async {
      await tester.pumpWidget(MyApp());

      expect(find.text('Like'), findsOneWidget);
      expect(find.text('Next'), findsOneWidget);
      expect(find.text('No Favorites Yet'), findsNothing);

      await tester.tap(find.text('Next'));
      await tester.pump();

      expect(find.text('Like'), findsOneWidget);
      expect(find.text('Next'), findsOneWidget);
      expect(find.text('No Favorites Yet'), findsNothing);

      await tester.tap(find.text('Like'));
      await tester.pump();

      final BigCard bigCardWidget = tester.widget(find.byType(BigCard));

      final String initialText = bigCardWidget.wordPair.asLowerCase;

      print(initialText);

      expect(find.text('No Favorites Yet'), findsNothing);

      await tester.tap(find.byIcon(Icons.favorite));
      await tester.pumpAndSettle();

      expect(find.text('You have 1 favorites:'), findsOneWidget);
    });
  });
}
