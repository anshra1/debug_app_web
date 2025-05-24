import 'package:flutter_test/flutter_test.dart';

import '../../../../../src2/features/error_tracking/data/models/current_error_details_model.dart';
import '../../../../../src2/features/error_tracking/domain/entities/entity_keys.dart';

void main() {
  group('ErrorDetailsModel', () {
    test('fromJson should return a valid model', () {
      final json = {
        EntityKeys.errorId: '1',
        EntityKeys.rootCauseName: 'cause',
        EntityKeys.rootCauseLineNumber: '42',
        EntityKeys.stackTrace: 'trace',
        EntityKeys.surroundingCode: 'code',
        EntityKeys.humanDescription: 'description',
        EntityKeys.additionalInfo: {'key': 'value'},
      };

      final model = ErrorDetailsModel.fromJson(json);

      expect(model.id, '1');
      expect(model.rootCauseName, 'cause');
      expect(model.rootCauseLineNumber, '42');
      expect(model.stackTrace, 'trace');
      expect(model.surroundingCode, 'code');
      expect(model.humanDescription, 'description');
      expect(model.additionalInfo, {'key': 'value'});
    });

    test('toJson should return a valid json', () {
      const model = ErrorDetailsModel(
        id: '1',
        rootCauseName: 'cause',
        rootCauseLineNumber: '42',
        stackTrace: 'trace',
        surroundingCode: 'code',
        humanDescription: 'description',
        additionalInfo: {'key': 'value'},
      );

      final json = model.toJson();

      expect(json[EntityKeys.errorId], '1');
      expect(json[EntityKeys.rootCauseName], 'cause');
      expect(json[EntityKeys.rootCauseLineNumber], '42');
      expect(json[EntityKeys.stackTrace], 'trace');
      expect(json[EntityKeys.surroundingCode], 'code');
      expect(json[EntityKeys.humanDescription], 'description');
      expect(json[EntityKeys.additionalInfo], {'key': 'value'});
    });

    test('copy should return a valid copy of the model', () {
      const model = ErrorDetailsModel(
        id: '1',
        rootCauseName: 'cause',
        rootCauseLineNumber: '42',
        stackTrace: 'trace',
        surroundingCode: 'code',
        humanDescription: 'description',
        additionalInfo: {'key': 'value'},
      );

      final copiedModel = model.copy();

      expect(copiedModel.id, model.id);
      expect(copiedModel.rootCauseName, model.rootCauseName);
      expect(copiedModel.rootCauseLineNumber, model.rootCauseLineNumber);
      expect(copiedModel.stackTrace, model.stackTrace);
      expect(copiedModel.surroundingCode, model.surroundingCode);
      expect(copiedModel.humanDescription, model.humanDescription);
      expect(copiedModel.additionalInfo, model.additionalInfo);
    });

    test('copyWith should return a valid copy of the model with updated fields', () {
      const model = ErrorDetailsModel(
        id: '1',
        rootCauseName: 'cause',
        rootCauseLineNumber: '42',
        stackTrace: 'trace',
        surroundingCode: 'code',
        humanDescription: 'description',
        additionalInfo: {'key': 'value'},
      );

      final updatedModel = model.copyWith(
        id: '2',
        rootCauseName: 'new cause',
        rootCauseLineNumber: '43',
        stackTrace: 'new trace',
        surroundingCode: 'new code',
        humanDescription: 'new description',
        additionalInfo: {'newKey': 'newValue'},
      );

      expect(updatedModel.id, '2');
      expect(updatedModel.rootCauseName, 'new cause');
      expect(updatedModel.rootCauseLineNumber, '43');
      expect(updatedModel.stackTrace, 'new trace');
      expect(updatedModel.surroundingCode, 'new code');
      expect(updatedModel.humanDescription, 'new description');
      expect(updatedModel.additionalInfo, {'newKey': 'newValue'});
    });
  });
}
