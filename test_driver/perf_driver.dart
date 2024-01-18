import 'package:flutter_driver/flutter_driver.dart' as driver;
import 'package:integration_test/integration_test_driver.dart';

Future<void> main() {
  return integrationDriver(
    responseDataCallback: (data) async {
      if (data != null) {
        final timeline = driver.Timeline.fromJson(
            data['main_summary'] as Map<String, dynamic>);

        final summary = driver.TimelineSummary.summarize(timeline);

        await summary.writeTimelineToFile(
          'main_summary',
          pretty: true,
          includeSummary: true,
        );
      }
    },
  );
}
