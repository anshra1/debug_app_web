// // ignore_for_file: avoid_dynamic_calls

// import 'package:debug_app_web/src/features/error_tracking/data/models/comment_model.dart';
// import 'package:debug_app_web/src/features/error_tracking/data/models/error_details_model.dart';
// import 'package:debug_app_web/src/features/error_tracking/data/models/error_environment_model.dart';
// import 'package:debug_app_web/src/features/error_tracking/data/models/error_tracking_dates_model.dart';
// import 'package:debug_app_web/src/features/error_tracking/data/models/error_tracking_entity_model.dart';
// import 'package:debug_app_web/src/features/error_tracking/domain/entities/entity_keys.dart';
// import 'package:debug_app_web/src/features/error_tracking/domain/entities/solution.dart';
// import 'package:debug_app_web/src/features/error_tracking/domain/enum/enum.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   group('ErrorTrackingEntityModel', () {
//     test('fromJson should return a valid model', () {
//       final json = {
//         EntityKeys.errorId: '1',
//         EntityKeys.details: {
//           EntityKeys.errorId: '1',
//           EntityKeys.rootCauseName: 'rootCause',
//           EntityKeys.rootCauseLineNumber: '42',
//           EntityKeys.stackTrace: 'stackTrace',
//         },
//         EntityKeys.errorPriority: 0,
//         EntityKeys.environment: {
//           EntityKeys.projectName: ['project'],
//           EntityKeys.flutterVersion: ['2.0.0'],
//           EntityKeys.dartVersion: ['2.12.0'],
//           EntityKeys.platform: ['web'],
//         },
//         EntityKeys.errorCategory: 1,
//         EntityKeys.tags: ['tag1', 'tag2'],
//         EntityKeys.dates: {
//           EntityKeys.created: '2023-01-01T00:00:00.000Z',
//           EntityKeys.modified: '2023-01-02T00:00:00.000Z',
//           EntityKeys.lastOccurrence: '2023-01-03T00:00:00.000Z',
//         },
//         EntityKeys.embeddingText: 'embeddingText',
//         EntityKeys.errorState: 2,
//         EntityKeys.similarityScore: 90,
//         EntityKeys.errorFrequency: 5,
//         EntityKeys.timeToResolve: 3600000,
//         EntityKeys.solutions: [
//           {
//             EntityKeys.solutionId: '1',
//             EntityKeys.codes: 'code',
//             EntityKeys.humanDescription: 'description',
//             EntityKeys.created: '2023-01-01',
//             EntityKeys.upvotes: 10,
//             EntityKeys.downvotes: 2,
//             EntityKeys.isVerified: true,
//             EntityKeys.environment: {
//               EntityKeys.projectName: 'project',
//               EntityKeys.flutterVersion: '2.0.0',
//               EntityKeys.dartVersion: '2.12.0',
//               EntityKeys.platform: 'web',
//             },
//             EntityKeys.url: 'http://example.com',
//             EntityKeys.comments: <String>[],
//           }
//         ],
//         EntityKeys.comments: [
//           {
//             EntityKeys.commentId: '1',
//             EntityKeys.commentAuthor: 'author',
//             EntityKeys.commentText: 'text',
//             EntityKeys.commentDateAdded: '2023-01-01T00:00:00.000Z',
//             EntityKeys.commentAdditionalInfo: {'key': 'value'},
//           }
//         ],
//         EntityKeys.relatedErrors: ['relatedError1', 'relatedError2'],
//         EntityKeys.totalOccurrences: 10,
//       };

//       final model = ErrorTrackingEntityModel.fromJson(json);

//       expect(model.id, '1');
//       expect(model.details.id, '1');
//       expect(model.details.rootCauseName, 'rootCause');
//       expect(model.details.rootCauseLineNumber, '42');
//       expect(model.details.stackTrace, 'stackTrace');
//       expect(model.errorPriority, ErrorPriority.low);
//       expect(model.environment?.projectName, ['project']);
//       expect(model.errorCategory, ErrorCategory.Network);
//       expect(model.tags, ['tag1', 'tag2']);
//       expect(model.dates?.created, DateTime.parse('2023-01-01T00:00:00.000Z'));
//       expect(model.embeddingText, 'embeddingText');
//       expect(model.errorState, ErrorStates.Resolved);
//       expect(model.similarityScore, 90);
//       expect(model.errorFrequency, 5);
//       expect(model.timeToResolve, const Duration(milliseconds: 3600000));
//       expect(model.solutions?.first.id, '1');
//       expect(model.comments?.first.id, '1');
//       expect(model.relatedErrors, ['relatedError1', 'relatedError2']);
//       expect(model.totalOccurrences, 10);
//     });

//     test('toJson should return a valid json', () {
//       final model = ErrorTrackingEntityModel(
//         id: '1',
//         details: const ErrorDetailsModel(
//           id: '1',
//           rootCauseName: 'rootCause',
//           rootCauseLineNumber: '42',
//           stackTrace: 'stackTrace',
//         ),
//         errorPriority: ErrorPriority.low,
//         environment: const ErrorEnvironmentModel(
//           projectName: ['project'],
//           flutterVersion: ['2.0.0'],
//           dartVersion: ['2.12.0'],
//           platform: ['web'],
//         ),
//         errorCategory: ErrorCategory.Network,
//         tags: const ['tag1', 'tag2'],
//         dates: ErrorTrackingDatesModel(
//           created: DateTime.parse('2023-01-01T00:00:00.000Z'),
//           modified: DateTime.parse('2023-01-02T00:00:00.000Z'),
//           lastOccurrence: DateTime.parse('2023-01-03T00:00:00.000Z'),
//         ),
//         embeddingText: 'embeddingText',
//         errorState: ErrorStates.New,
//         similarityScore: 90,
//         errorFrequency: 5,
//         timeToResolve: const Duration(milliseconds: 3600000),
//         solutions: const [
//           Solution(
//             id: '1',
//             codes: 'code',
//             humanDescription: 'description',
//             date: '2023-01-01',
//             upvotes: 10,
//             downvotes: 2,
//             isVerified: true,
//             environment: SolutionEnvironment(
//               projectName: 'project',
//               flutterVersion: '2.0.0',
//               dartVersion: '2.12.0',
//               platform: 'web',
//             ),
//             url: 'http://example.com',
//             comments: [],
//           ),
//         ],
//         comments: [
//           CommentModel(
//             id: '1',
//             author: 'author',
//             text: 'text',
//             dateAdded: DateTime.parse('2023-01-01T00:00:00.000Z'),
//             additionalInfo: const {'key': 'value'},
//           ),
//         ],
//         relatedErrors: const ['relatedError1', 'relatedError2'],
//         totalOccurrences: 10,
//       );

//       final json = model.toJson();

//       expect(json[EntityKeys.errorId], '1');
//       expect(json[EntityKeys.details][EntityKeys.errorId], '1');
//       expect(json[EntityKeys.details][EntityKeys.rootCauseName], 'rootCause');
//       expect(json[EntityKeys.details][EntityKeys.rootCauseLineNumber], '42');
//       expect(json[EntityKeys.details][EntityKeys.stackTrace], 'stackTrace');
//       expect(json[EntityKeys.errorPriority], 0);
//       expect(json[EntityKeys.environment][EntityKeys.projectName], ['project']);
//       expect(json[EntityKeys.errorCategory], 1);
//       expect(json[EntityKeys.tags], ['tag1', 'tag2']);
//       expect(json[EntityKeys.dates][EntityKeys.created], '2023-01-01T00:00:00.000Z');
//       expect(json[EntityKeys.embeddingText], 'embeddingText');
//       expect(json[EntityKeys.errorState], 0);
//       expect(json[EntityKeys.similarityScore], 90);
//       expect(json[EntityKeys.errorFrequency], 5);
//       expect(json[EntityKeys.timeToResolve], 3600000);
//       expect(json[EntityKeys.solutions].first[EntityKeys.solutionId], '1');
//       expect(json[EntityKeys.comments].first[EntityKeys.commentId], '1');
//       expect(json[EntityKeys.relatedErrors], ['relatedError1', 'relatedError2']);
//       expect(json[EntityKeys.totalOccurrences], 10);
//     });

//     test('copy should return a valid copy of the model', () {
//       final model = ErrorTrackingEntityModel(
//         id: '1',
//         details: const ErrorDetailsModel(
//           id: '1',
//           rootCauseName: 'rootCause',
//           rootCauseLineNumber: '42',
//           stackTrace: 'stackTrace',
//         ),
//         errorPriority: ErrorPriority.low,
//         environment: const ErrorEnvironmentModel(
//           projectName: ['project'],
//           flutterVersion: ['2.0.0'],
//           dartVersion: ['2.12.0'],
//           platform: ['web'],
//         ),
//         errorCategory: ErrorCategory.UI_RENDERING,
//         tags: const ['tag1', 'tag2'],
//         dates: ErrorTrackingDatesModel(
//           created: DateTime.parse('2023-01-01T00:00:00.000Z'),
//           modified: DateTime.parse('2023-01-02T00:00:00.000Z'),
//           lastOccurrence: DateTime.parse('2023-01-03T00:00:00.000Z'),
//         ),
//         embeddingText: 'embeddingText',
//         errorState: ErrorStates.New,
//         similarityScore: 90,
//         errorFrequency: 5,
//         timeToResolve: const Duration(milliseconds: 3600000),
//         solutions: const [
//           Solution(
//             id: '1',
//             codes: 'code',
//             humanDescription: 'description',
//             date: '2023-01-01',
//             upvotes: 10,
//             downvotes: 2,
//             isVerified: true,
//             environment: SolutionEnvironment(
//               projectName: 'project',
//               flutterVersion: '2.0.0',
//               dartVersion: '2.12.0',
//               platform: 'web',
//             ),
//             url: 'http://example.com',
//             comments: [],
//           ),
//         ],
//         comments: [
//           CommentModel(
//             id: '1',
//             author: 'author',
//             text: 'text',
//             dateAdded: DateTime.parse('2023-01-01T00:00:00.000Z'),
//             additionalInfo: const {'key': 'value'},
//           ),
//         ],
//       );

//       final copy = model.copyWith();

//       expect(copy.id, model.id);
//       expect(copy.details.id, model.details.id);
//       expect(copy.details.rootCauseName, model.details.rootCauseName);
//       expect(copy.details.rootCauseLineNumber, model.details.rootCauseLineNumber);
//       expect(copy.details.stackTrace, model.details.stackTrace);
//       expect(copy.errorPriority, model.errorPriority);
//       expect(copy.environment?.projectName, model.environment?.projectName);
//       expect(copy.errorCategory, model.errorCategory);
//       expect(copy.tags, model.tags);
//       expect(copy.dates?.created, model.dates?.created);
//       expect(copy.embeddingText, model.embeddingText);
//       expect(copy.errorState, model.errorState);
//       expect(copy.similarityScore, model.similarityScore);
//       expect(copy.errorFrequency, model.errorFrequency);
//       expect(copy.timeToResolve, model.timeToResolve);
//       expect(copy.solutions?.first.id, model.solutions?.first.id);
//       expect(copy.comments?.first.id, model.comments?.first.id);
//       expect(copy.relatedErrors, model.relatedErrors);
//       expect(copy.totalOccurrences, model.totalOccurrences);
//     });
//   });
// }
