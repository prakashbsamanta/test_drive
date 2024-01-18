import 'package:english_words/english_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:test_drive/main.dart';

void main() {
  group("GeneratorPage widget test", () {
    Widget createHomeScreen() => ChangeNotifierProvider(
          create: (context) => MyAppState(),
          child: MaterialApp(
            home: GeneratorPage(),
          ),
        );
    testWidgets('GeneratorPage verify layout', (tester) async {
      await tester.pumpWidget(createHomeScreen());
      Finder findLikeButton() => find.text('Like');
      Finder findNextButton() => find.text('Next');
      expect(findLikeButton(), findsOneWidget);
      expect(findNextButton(), findsOneWidget);
      await tester.tap(find.text('Next'));
      await tester.pump();

      // final MyAppState appState = tester.state(find.byType(MyAppState));
      // final WordPair currentWordPair = appState.current;

      expect(findLikeButton(), findsOneWidget);
      expect(findNextButton(), findsOneWidget);

      //  expect(find.text(currentWordPair.asLowerCase), findsOneWidget);
    });
  });

  group('FavoritesPage widget Tests', () {
    Widget createHomeScreen() => ChangeNotifierProvider(
          create: (context) => MyAppState(),
          child: MaterialApp(
            home: FavoritesPage(),
          ),
        );
    addWordToFavorites(WidgetTester tester, String first, String second) async {
      final MyAppState appState = tester.state(find.byType(MyAppState));
      appState.favorites.add(WordPair(first, second));

      // Rebuild the widget tree.
      await tester.pump();
    }

    testWidgets('Initial state and adding a favorite',
        (WidgetTester tester) async {
      // Build our app and trigger a frame.
      await tester.pumpWidget(createHomeScreen());

      // Helper function to find the 'No Favorites Yet' text.
      Finder findNoFavoritesText() => find.text('No Favorites Yet');

      // Verify initial state of FavoritesPage.
      expect(findNoFavoritesText(), findsOneWidget);

      // Access the current MyAppState and add a WordPair to favorites.
      final MyAppState appState = tester.state(find.byType(MyAppState));
      appState.favorites.add(WordPair('test', 'word'));

      // Rebuild the widget tree.
      await tester.pumpAndSettle();

      // Verify updated state after adding a favorite.
      expect(findNoFavoritesText(), findsNothing);
      expect(find.text('test word'), findsOneWidget);
      expect(find.text('test word'), findsOneWidget);
    });

    // Add more tests for FavoritesPage as needed.
  });
}
