import 'package:flutter_test/flutter_test.dart';

import '../../../../../src2/features/error_tracking/domain/entities/error_tracking_dates.dart';

void main() {
  group('ErrorTrackingDates', () {
    test('props', () {
      final errorTrackingDates = ErrorTrackingDates(
        created: DateTime(2023),
        modified: DateTime(2023, 1, 2),
        lastOccurrence: DateTime(2023, 1, 3),
      );

      expect(
        errorTrackingDates.props,
        [
          DateTime(2023),
          DateTime(2023, 1, 2),
          DateTime(2023, 1, 3),
        ],
      );
    });
  });
}
