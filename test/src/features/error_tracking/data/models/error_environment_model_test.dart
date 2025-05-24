import 'package:flutter_test/flutter_test.dart';

import '../../../../../src2/features/error_tracking/data/models/error_environment_model.dart';
import '../../../../../src2/features/error_tracking/domain/entities/entity_keys.dart';

void main() {
  group('ErrorEnvironmentModel', () {
    test('fromJson should return a valid model', () {
      final json = {
        EntityKeys.projectName: ['project'],
        EntityKeys.flutterVersion: ['2.0.0'],
        EntityKeys.dartVersion: ['2.12.0'],
        EntityKeys.platform: ['web'],
      };

      final model = ErrorEnvironmentModel.fromJson(json);

      expect(model.projectName, ['project']);
      expect(model.flutterVersion, ['2.0.0']);
      expect(model.dartVersion, ['2.12.0']);
      expect(model.platform, ['web']);
    });

    test('toJson should return a valid json', () {
      const model = ErrorEnvironmentModel(
        projectName: ['project'],
        flutterVersion: ['2.0.0'],
        dartVersion: ['2.12.0'],
        platform: ['web'],
      );

      final json = model.toJson();

      expect(json[EntityKeys.projectName], ['project']);
      expect(json[EntityKeys.flutterVersion], ['2.0.0']);
      expect(json[EntityKeys.dartVersion], ['2.12.0']);
      expect(json[EntityKeys.platform], ['web']);
    });

    test('copy should return a valid copy of the model', () {
      const model = ErrorEnvironmentModel(
        projectName: ['project'],
        flutterVersion: ['2.0.0'],
        dartVersion: ['2.12.0'],
        platform: ['web'],
      );

      final copiedModel = model.copy();

      expect(copiedModel.projectName, model.projectName);
      expect(copiedModel.flutterVersion, model.flutterVersion);
      expect(copiedModel.dartVersion, model.dartVersion);
      expect(copiedModel.platform, model.platform);
      expect(copiedModel.osVersion, model.osVersion);
      expect(copiedModel.deviceModel, model.deviceModel);
      expect(copiedModel.additionalInfo, model.additionalInfo);
    });

    test('copyWith should return a valid copy of the model with updated fields', () {
      const model = ErrorEnvironmentModel(
        projectName: ['project'],
        flutterVersion: ['2.0.0'],
        dartVersion: ['2.12.0'],
        platform: ['web'],
      );

      final updatedModel = model.copyWith(
        projectName: ['new project'],
        flutterVersion: ['2.1.0'],
        dartVersion: ['2.13.0'],
        platform: ['mobile'],
        osVersion: ['new os'],
        deviceModel: ['new device'],
        additionalInfo: {'key': 'value'},
      );

      expect(updatedModel.projectName, ['new project']);
      expect(updatedModel.flutterVersion, ['2.1.0']);
      expect(updatedModel.dartVersion, ['2.13.0']);
      expect(updatedModel.platform, ['mobile']);
      expect(updatedModel.osVersion, ['new os']);
      expect(updatedModel.deviceModel, ['new device']);
      expect(updatedModel.additionalInfo, {'key': 'value'});
    });
  });
}
