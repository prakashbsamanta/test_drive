import 'package:test/test.dart';
import 'package:test_drive/main.dart';

void main() {
  group("Testing main file", () {
    test("getNext should update the current WordPair", () {
      final appState = MyAppState();
      final initialWordPair = appState.current;
      appState.getNext();
      expect(appState.current, isNot(equals(initialWordPair)));
    });
    test("Calling getNext and toggleFavorite should work together", () {
      final appState = MyAppState();
      final initialFavoritesCount = appState.favorites.length;

      appState.getNext();
      appState.toggleFavorite();
      expect(appState.favorites.length, equals(initialFavoritesCount + 1));
      appState.getNext();
      expect(appState.favorites.length, equals(initialFavoritesCount + 1));
    });

    test("Calling getNext with existing favorite should remove it", () {
      final appState = MyAppState();
      final initialFavoritesCount = appState.favorites.length;

      appState.getNext();

      appState.favorites.add(appState.current);

      appState.toggleFavorite();
      expect(appState.favorites.length, equals(initialFavoritesCount));
      expect(appState.favorites.contains(appState.current), isFalse);
    });
  });
}
