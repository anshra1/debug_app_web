import 'package:flutter_test/flutter_test.dart';

import '../../../../../src2/features/error_tracking/data/models/comment_model.dart';
import '../../../../../src2/features/error_tracking/domain/entities/entity_keys.dart';

void main() {
  group('CommentModel', () {
    test('fromJson should return a valid model', () {
      final json = {
        EntityKeys.commentId: '1',
        EntityKeys.commentAuthor: 'author',
        EntityKeys.commentText: 'text',
        EntityKeys.commentDateAdded: '2023-01-01T00:00:00.000Z',
        EntityKeys.commentAdditionalInfo: {'key': 'value'},
      };

      final model = CommentModel.fromJson(json);

      expect(model.id, '1');
      expect(model.author, 'author');
      expect(model.text, 'text');
      expect(model.dateAdded, DateTime.parse('2023-01-01T00:00:00.000Z'));
      expect(model.additionalInfo, {'key': 'value'});
    });

    test('toJson should return a valid json', () {
      final model = CommentModel(
        id: '1',
        author: 'author',
        text: 'text',
        dateAdded: DateTime.parse('2023-01-01T00:00:00.000Z'),
        additionalInfo: const {'key': 'value'},
      );

      final json = model.toJson();

      expect(json[EntityKeys.commentId], '1');
      expect(json[EntityKeys.commentAuthor], 'author');
      expect(json[EntityKeys.commentText], 'text');
      expect(json[EntityKeys.commentDateAdded], '2023-01-01T00:00:00.000Z');
      expect(json[EntityKeys.commentAdditionalInfo], {'key': 'value'});
    });

    test('copy should return a valid copy of the model', () {
      final model = CommentModel(
        id: '1',
        author: 'author',
        text: 'text',
        dateAdded: DateTime.parse('2023-01-01T00:00:00.000Z'),
        additionalInfo: const {'key': 'value'},
      );

      final copiedModel = model.copy();

      expect(copiedModel.id, model.id);
      expect(copiedModel.author, model.author);
      expect(copiedModel.text, model.text);
      expect(copiedModel.dateAdded, model.dateAdded);
      expect(copiedModel.additionalInfo, model.additionalInfo);
    });

    test('copyWith should return a valid copy of the model with updated fields', () {
      final model = CommentModel(
        id: '1',
        author: 'author',
        text: 'text',
        dateAdded: DateTime.parse('2023-01-01T00:00:00.000Z'),
        additionalInfo: const {'key': 'value'},
      );

      final updatedModel = model.copyWith(
        id: '2',
        author: 'new author',
        text: 'new text',
        dateAdded: DateTime.parse('2023-02-01T00:00:00.000Z'),
        additionalInfo: {'newKey': 'newValue'},
      );

      expect(updatedModel.id, '2');
      expect(updatedModel.author, 'new author');
      expect(updatedModel.text, 'new text');
      expect(updatedModel.dateAdded, DateTime.parse('2023-02-01T00:00:00.000Z'));
      expect(updatedModel.additionalInfo, {'newKey': 'newValue'});
    });
  });
}
