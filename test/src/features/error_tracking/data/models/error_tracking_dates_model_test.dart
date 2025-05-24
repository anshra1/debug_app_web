import 'package:flutter_test/flutter_test.dart';

import '../../../../../src2/features/error_tracking/data/models/error_tracking_dates_model.dart';
import '../../../../../src2/features/error_tracking/domain/entities/entity_keys.dart';

void main() {
  group('ErrorTrackingDatesModel', () {
    test('fromJson should return a valid model', () {
      final json = {
        EntityKeys.created: '2023-01-01T00:00:00.000Z',
        EntityKeys.modified: '2023-01-02T00:00:00.000Z',
        EntityKeys.lastOccurrence: '2023-01-03T00:00:00.000Z',
      };

      final model = ErrorTrackingDatesModel.fromJson(json);

      expect(model.created, DateTime.parse('2023-01-01T00:00:00.000Z'));
      expect(model.modified, DateTime.parse('2023-01-02T00:00:00.000Z'));
      expect(model.lastOccurrence, DateTime.parse('2023-01-03T00:00:00.000Z'));
    });

    test('toJson should return a valid json', () {
      final model = ErrorTrackingDatesModel(
        created: DateTime.parse('2023-01-01T00:00:00.000Z'),
        modified: DateTime.parse('2023-01-02T00:00:00.000Z'),
        lastOccurrence: DateTime.parse('2023-01-03T00:00:00.000Z'),
      );

      final json = model.toJson();

      expect(json[EntityKeys.created], '2023-01-01T00:00:00.000Z');
      expect(json[EntityKeys.modified], '2023-01-02T00:00:00.000Z');
      expect(json[EntityKeys.lastOccurrence], '2023-01-03T00:00:00.000Z');
    });

    test('copy should return a valid copy of the model', () {
      final model = ErrorTrackingDatesModel(
        created: DateTime.parse('2023-01-01T00:00:00.000Z'),
        modified: DateTime.parse('2023-01-02T00:00:00.000Z'),
        lastOccurrence: DateTime.parse('2023-01-03T00:00:00.000Z'),
      );

      final copiedModel = model.copy();

      expect(copiedModel.created, model.created);
      expect(copiedModel.modified, model.modified);
      expect(copiedModel.lastOccurrence, model.lastOccurrence);
    });

    test('copyWith should return a valid copy of the model with updated fields', () {
      final model = ErrorTrackingDatesModel(
        created: DateTime.parse('2023-01-01T00:00:00.000Z'),
        modified: DateTime.parse('2023-01-02T00:00:00.000Z'),
        lastOccurrence: DateTime.parse('2023-01-03T00:00:00.000Z'),
      );

      final updatedModel = model.copyWith(
        created: DateTime.parse('2023-02-01T00:00:00.000Z'),
        modified: DateTime.parse('2023-02-02T00:00:00.000Z'),
        lastOccurrence: DateTime.parse('2023-02-03T00:00:00.000Z'),
      );

      expect(updatedModel.created, DateTime.parse('2023-02-01T00:00:00.000Z'));
      expect(updatedModel.modified, DateTime.parse('2023-02-02T00:00:00.000Z'));
      expect(updatedModel.lastOccurrence, DateTime.parse('2023-02-03T00:00:00.000Z'));
    });
  });
}
