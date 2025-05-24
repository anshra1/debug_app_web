import 'package:flutter_test/flutter_test.dart';

import '../../../../../src2/features/error_tracking/data/models/solution_model.dart';
import '../../../../../src2/features/error_tracking/domain/entities/entity_keys.dart';

void main() {
  group('SolutionModel', () {
    test('fromJson should return a valid model', () {
      final json = {
        EntityKeys.solutionId: '1',
        EntityKeys.codes: 'code',
        EntityKeys.humanDescription: 'description',
        EntityKeys.created: '2023-01-01',
        EntityKeys.upvotes: 10,
        EntityKeys.downvotes: 2,
        EntityKeys.isVerified: true,
        EntityKeys.environment: {
          EntityKeys.projectName: 'project',
          EntityKeys.flutterVersion: '2.0.0',
          EntityKeys.dartVersion: '2.12.0',
          EntityKeys.platform: 'web',
        },
        EntityKeys.url: 'http://example.com',
        EntityKeys.comments: <String>[],
      };

      final model = SolutionModel.fromJson(json);

      expect(model.id, '1');
      expect(model.codes, 'code');
      expect(model.humanDescription, 'description');
      expect(model.date, '2023-01-01');
      expect(model.upvotes, 10);
      expect(model.downvotes, 2);
      expect(model.isVerified, true);
      expect(model.environment?.projectName, 'project');
      expect(model.url, 'http://example.com');
      expect(model.comments, isEmpty);
    });

    test('toJson should return a valid json', () {
      const model = SolutionModel(
        id: '1',
        codes: 'code',
        humanDescription: 'description',
        date: '2023-01-01',
        upvotes: 10,
        downvotes: 2,
        isVerified: true,
        environment: SolutionEnvironmentModel(
          projectName: 'project',
          flutterVersion: '2.0.0',
          dartVersion: '2.12.0',
          platform: 'web',
        ),
        url: 'http://example.com',
        comments: [],
      );

      final json = model.toJson();

      expect(json[EntityKeys.solutionId], '1');
      expect(json[EntityKeys.codes], 'code');
      expect(json[EntityKeys.humanDescription], 'description');
      expect(json[EntityKeys.created], '2023-01-01');
      expect(json[EntityKeys.upvotes], 10);
      expect(json[EntityKeys.downvotes], 2);
      expect(json[EntityKeys.isVerified], true);
      // ignore: avoid_dynamic_calls
      expect(json[EntityKeys.environment][EntityKeys.projectName], 'project');
      expect(json[EntityKeys.url], 'http://example.com');
      expect(json[EntityKeys.comments], isEmpty);
    });

    test('copy should return a valid copy of the model', () {
      const model = SolutionModel(
        id: '1',
        codes: 'code',
        humanDescription: 'description',
        date: '2023-01-01',
        upvotes: 10,
        downvotes: 2,
        isVerified: true,
        environment: SolutionEnvironmentModel(
          projectName: 'project',
          flutterVersion: '2.0.0',
          dartVersion: '2.12.0',
          platform: 'web',
        ),
        url: 'http://example.com',
        comments: [],
      );

      final copiedModel = model.copy();

      expect(copiedModel.id, model.id);
      expect(copiedModel.codes, model.codes);
      expect(copiedModel.humanDescription, model.humanDescription);
      expect(copiedModel.date, model.date);
      expect(copiedModel.upvotes, model.upvotes);
      expect(copiedModel.downvotes, model.downvotes);
      expect(copiedModel.isVerified, model.isVerified);
      expect(copiedModel.environment, model.environment);
      expect(copiedModel.url, model.url);
      expect(copiedModel.comments, model.comments);
    });

    test('copyWith should return a valid copy of the model with updated fields', () {
      const model = SolutionModel(
        id: '1',
        codes: 'code',
        humanDescription: 'description',
        date: '2023-01-01',
        upvotes: 10,
        downvotes: 2,
        isVerified: true,
        environment: SolutionEnvironmentModel(
          projectName: 'project',
          flutterVersion: '2.0.0',
          dartVersion: '2.12.0',
          platform: 'web',
        ),
        url: 'http://example.com',
        comments: [],
      );

      final updatedModel = model.copyWith(
        id: '2',
        codes: 'new code',
        humanDescription: 'new description',
        date: '2023-02-01',
        upvotes: 20,
        downvotes: 5,
        isVerified: false,
        environment: const SolutionEnvironmentModel(
          projectName: 'new project',
          flutterVersion: '2.1.0',
          dartVersion: '2.13.0',
          platform: 'mobile',
        ),
        url: 'http://newexample.com',
        comments: [],
      );

      expect(updatedModel.id, '2');
      expect(updatedModel.codes, 'new code');
      expect(updatedModel.humanDescription, 'new description');
      expect(updatedModel.date, '2023-02-01');
      expect(updatedModel.upvotes, 20);
      expect(updatedModel.downvotes, 5);
      expect(updatedModel.isVerified, false);
      expect(updatedModel.environment?.projectName, 'new project');
      expect(updatedModel.url, 'http://newexample.com');
      expect(updatedModel.comments, isEmpty);
    });
  });
}
