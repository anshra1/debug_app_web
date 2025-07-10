// import 'dart:convert';

// import 'package:crypto/crypto.dart';
// import 'package:debug_app_web/m.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_test/flutter_test.dart';
// import 'package:integration_test/integration_test.dart';

// import 'package:debug_app_web/main.dart'; // Adjust based on your app structure
// import 'package:debug_app_web/fingerprint.dart'; // Import fingerprint logic

// void main() {
//   IntegrationTestWidgetsFlutterBinding.ensureInitialized();

//   group('ErrorTestPage Fingerprint Tests', () {
//     late List<String> capturedFingerprints = [];

//     setUp(() async {
//       capturedFingerprints.clear();
//     });

//     Future<void> setupErrorTestPage(WidgetTester tester) async {
//       await tester.pumpWidget(const MaterialApp(
//         home: ErrorTestPage(),
//       ));
//       await tester.pumpAndSettle();
//     }

//     // Mock version of MinimalErrorFingerprinter for verification
  
//     testWidgets('loads the page successfully', (tester) async {
//       await setupErrorTestPage(tester);

//       expect(find.byType(Scaffold), findsOneWidget);
//       expect(find.byType(AppBar), findsOneWidget);
//       expect(find.text('Error Test Page'), findsOneWidget);
//       expect(find.byType(ElevatedButton), findsNWidgets(50));
//     });

//     testWidgets('displays 25 unique error buttons', (tester) async {
//       await setupErrorTestPage(tester);

//       final uniqueButtons = find.byWidgetPredicate((widget) =>
//           widget is ElevatedButton &&
//           widget.child is Text &&
//           !widget.child.toString().contains('Similar'));

//       expect(uniqueButtons, findsNWidgets(25));
//     });

//     testWidgets('displays 25 similar error buttons', (tester) async {
//       await setupErrorTestPage(tester);

//       final similarButtons = find.byWidgetPredicate((widget) =>
//           widget is ElevatedButton &&
//           widget.child is Text &&
//           widget.child.toString().contains('Similar'));

//       expect(similarButtons, findsNWidgets(25));
//     });

//     testWidgets('triggers unique errors and generates fingerprints', (tester) async {
//       await setupErrorTestPage(tester);

//       final uniqueButtons = find.byWidgetPredicate((widget) =>
//           widget is ElevatedButton &&
//           widget.child is Text &&
//           !widget.child.toString().contains('Similar'));

//       for (int i = 0; i < 25; i++) {
//         final button = uniqueButtons.at(i);
//         await tester.tap(button);
//         await tester.pump(Duration(milliseconds: 100));

//         // Check if any print statements or logs contain the fingerprint
//         // In real use, this would connect to a backend or logging system
//         expect(capturedFingerprints.length, equals(i + 1));
//       }
//     });

//     testWidgets('similar errors produce same fingerprint', (tester) async {
//       await setupErrorTestPage(tester);

//       final similarButtons = find.byWidgetPredicate((widget) =>
//           widget is ElevatedButton &&
//           widget.child is Text &&
//           widget.child.toString().contains('Similar'));

//       String? baseFingerprint;

//       for (int i = 0; i < 25; i++) {
//         final button = similarButtons.at(i);
//         await tester.tap(button);
//         await tester.pump(Duration(milliseconds: 100));

//         final context = 'Custom test $i';
//         final exception = TypeError();
//         final stackTrace = StackTrace.current;
//         final errorBlock = '''
// === FLUTTER ERROR DETAILS ===
// Exception Type: ${exception.runtimeType}
// Exception: type '${i % 2 == 0 ? 'String' : 'double'}' is not a subtype of type 'int' in type cast
// Library: Error Testing
// Context: $context
// Stack Trace: $stackTrace
// Information Collector: null
// Silent: false
// === END ERROR DETAILS ===
// Flutter error: type '${i % 2 == 0 ? 'String' : 'double'}' is not a subtype of type 'int' in type cast
// ''';

//         final fingerprint = MinimalErrorFingerprinter.generateFingerprint(errorBlock);

//         if (i == 0) {
//           baseFingerprint = fingerprint;
//         } else {
//           expect(fingerprint, baseFingerprint);
//         }

//         capturedFingerprints.add(fingerprint);
//       }

//       expect(capturedFingerprints.toSet().length, 1); // Only one unique hash
//     });

//     testWidgets('unique errors produce different fingerprints', (tester) async {
//       await setupErrorTestPage(tester);

//       final uniqueButtons = find.byWidgetPredicate((widget) =>
//           widget is ElevatedButton &&
//           widget.child is Text &&
//           !widget.child.toString().contains('Similar'));

//       Set<String> uniqueFingerprints = {};

//       for (int i = 0; i < 25; i++) {
//         final button = uniqueButtons.at(i);
//         await tester.tap(button);
//         await tester.pump(Duration(milliseconds: 100));

//         final context = 'Unique error test $i';
//         final exception = Exception('Unique error message $i');
//         final stackTrace = StackTrace.current;
//         final errorBlock = '''
// === FLUTTER ERROR DETAILS ===
// Exception Type: ${exception.runtimeType}
// Exception: $exception
// Library: Error Testing
// Context: $context
// Stack Trace: $stackTrace
// Information Collector: null
// Silent: false
// === END ERROR DETAILS ===
// Flutter error: $exception
// ''';

//         final fingerprint = MinimalErrorFingerprinter.generateFingerprint(errorBlock);
//         uniqueFingerprints.add(fingerprint);
//       }

//       expect(uniqueFingerprints.length, greaterThanOrEqualTo(20)); // Allow some overlaps
//     });

//     testWidgets('error block formatting is consistent', (tester) async {
//       await setupErrorTestPage(tester);

//       final button = find.byWidgetPredicate((widget) =>
//           widget is ElevatedButton && widget.child is Text);

//       await tester.tap(button.first);
//       await tester.pump(Duration(milliseconds: 100));

//       final exception = Exception('Sample error');
//       final stackTrace = StackTrace.current;
//       final formatted = formatError(exception, stackTrace);

//       expect(formatted.contains('Exception Type:'), true);
//       expect(formatted.contains('Exception: Sample error'), true);
//       expect(formatted.contains('Library: Error Testing'), true);
//       expect(formatted.contains('Context: Custom test'), true);
//       expect(formatted.contains('Stack Trace: '), true);
//       expect(formatted.contains('Flutter error: Sample error'), true);
//     });
//   });
// }

// // Helper function copied from your widget
// String formatError(dynamic exception, StackTrace stackTrace) {
//   return '''
// === FLUTTER ERROR DETAILS ===
// Exception Type: ${exception.runtimeType}
// Exception: $exception
// Library: Error Testing
// Context: Custom test
// Stack Trace: $stackTrace
// Information Collector: null
// Silent: false
// === END ERROR DETAILS ===
// Flutter error: $exception
// ''';
// }