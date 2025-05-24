// // ignore_for_file: prefer_const_constructors

// import 'package:debug_app_web/src/features/error_tracking/domain/entities/error_details.dart';
// import 'package:debug_app_web/src/features/error_tracking/domain/entities/error_environment.dart';
// import 'package:debug_app_web/src/features/error_tracking/domain/entities/error_tracking_dates.dart';
// import 'package:debug_app_web/src/features/error_tracking/domain/entities/error_tracking_entity.dart';
// import 'package:debug_app_web/src/features/error_tracking/domain/enum/enum.dart';
// import 'package:flutter_test/flutter_test.dart';

// void main() {
//   group('ErrorTrackingEntity', () {
//     test('props', () {
//       final errorTrackingEntity = ErrorTrackingEntity(
//         id: '1',
//         details: ErrorDetails(
//           id: '1',
//           rootCauseName: 'NullPointerException',
//           rootCauseLineNumber: '42',
//           stackTrace: 'stack trace',
//         ),
//         errorPriority: ErrorPriority.high,
//         errorCategory: ErrorCategory.Database,
//         tags: const ['tag1', 'tag2'],
//         environment: ErrorEnvironment(
//           projectName: const ['project'],
//           flutterVersion: const ['2.0.0'],
//           dartVersion: const ['2.12.0'],
//           platform: const ['web'],
//         ),
//         dates: ErrorTrackingDates(
//           created: DateTime(2023),
//           modified: DateTime(2023, 1, 2),
//           lastOccurrence: DateTime(2023, 1, 3),
//         ),
//         embeddingText: 'embedding text',
//         errorState: ErrorStates.New,
//         similarityScore: 90,
//         errorFrequency: 5,
//         timeToResolve: Duration(hours: 2),
//         solutions: const [],
//         comments: const [],
//         relatedErrors: const ['error2'],
//         totalOccurrences: 10,
//       );

//       expect(
//         errorTrackingEntity.props,
//         [
//           '1',
//           errorTrackingEntity.details,
//           ErrorPriority.high,
//           ErrorCategory.Database,
//           ['tag1', 'tag2'],
//           errorTrackingEntity.environment,
//           errorTrackingEntity.dates,
//           'embedding text',
//           ErrorStates.New,
//           90,
//           5,
//           const Duration(hours: 2),
//           [],
//           [],
//           ['error2'],
//           10,
//         ],
//       );
//     });
//   });
// }
