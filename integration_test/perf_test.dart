import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:test_drive/main.dart';

void main() {
  group('Testing App Performance', () {
    final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
    binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;

    testWidgets('Performance main test', (tester) async {
      await tester.pumpWidget(MyApp());

      // final listFinder = find.byType(ListView);

      await binding.traceAction(() async {
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
        await tester.pumpAndSettle();
        expect(find.text('You have 1 favorites:'), findsOneWidget);
      }, reportKey: 'main_summary');
    });
  });
}
