import 'package:flutter_test/flutter_test.dart';

import '../../../../../src2/features/error_tracking/domain/entities/comment.dart';

void main() {
  group('Comment', () {
    test('props', () {
      final comment = Comment(
        id: '1',
        author: 'author',
        text: 'text',
        dateAdded: DateTime(2023, 10),
        additionalInfo: const {'key': 'value'},
      );

      expect(
        comment.props,
        [
          '1',
          'author',
          'text',
          DateTime(2023, 10),
          {'key': 'value'},
        ],
      );
    });
  });
}
