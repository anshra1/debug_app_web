import 'package:flutter_test/flutter_test.dart';

import '../../../../../src2/features/error_tracking/domain/entities/current_error_details.dart';

void main() {
  group('ErrorDetails', () {
    test('props', () {
      const errorDetails = CurrentErrorDetails(
        id: '1',
        rootCauseName: 'NullPointerException',
        rootCauseLineNumber: '42',
        stackTrace: 'stack trace',
        surroundingCode: 'surrounding code',
        humanDescription: 'description',
        additionalInfo: {'key': 'value'},
      );

      expect(
        errorDetails.props,
        [
          '1',
          'NullPointerException',
          '42',
          'stack trace',
          'surrounding code',
          'description',
          {'key': 'value'},
        ],
      );
    });
  });
}
