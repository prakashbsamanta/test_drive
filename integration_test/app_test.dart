import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_drive/main.dart';

void main() {
  group('Testing App', () {
    testWidgets('Integration test for the main app', (tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(MyApp());

      // Verify the initial state of the GeneratorPage.
      expect(find.text('Like'), findsOneWidget);
      expect(find.text('Next'), findsOneWidget);
      expect(find.text('No Favorites Yet'), findsNothing);

      // Tap on the 'Next' button.
      await tester.tap(find.text('Next'));
      await tester.pump();

      // Verify the updated state after calling getNext on GeneratorPage.
      expect(find.text('Like'), findsOneWidget);
      expect(find.text('Next'), findsOneWidget);
      expect(find.text('No Favorites Yet'), findsNothing);

      // Tap on the 'Like' button.
      await tester.tap(find.text('Like'));
      await tester.pump();

      // Find the BigCard widget.
      final BigCard bigCardWidget = tester.widget(find.byType(BigCard));

      // Extract the text from the BigCard widget.
      final String initialText = bigCardWidget.wordPair.asLowerCase;

      print(initialText);

      // Verify that the liked word is added to favorites.
      expect(find.text('No Favorites Yet'), findsNothing);

      // Navigate to the FavoritesPage using the bottom navigation bar.
      await tester.tap(find.byIcon(Icons.favorite));
      await tester.pumpAndSettle();

      // Verify the state of the FavoritesPage.
      expect(find.text('You have 1 favorites:'), findsOneWidget);
    });
  });
}
