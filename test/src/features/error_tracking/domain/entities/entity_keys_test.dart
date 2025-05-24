import 'package:flutter_test/flutter_test.dart';

import '../../../../../src2/features/error_tracking/domain/entities/entity_keys.dart';

void main() {
  setUp(
    () {},
  );
  group('EntityKeys', () {
    test('Comment Keys', () {
      expect(EntityKeys.commentId, 'id');
      expect(EntityKeys.commentAuthor, 'author');
      expect(EntityKeys.commentText, 'text');
      expect(EntityKeys.commentDateAdded, 'dateAdded');
      expect(EntityKeys.commentAdditionalInfo, 'additionalInfo');
    });
  });
}