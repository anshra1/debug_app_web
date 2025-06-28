//   // ignore_for_file: require_trailing_commas

// import 'package:stack_trace/stack_trace.dart';

// class ErrorProcessor {
//   static const Map<String, String> _errorPatterns = {
//     'SocketException': 'Network Error',
//     'MissingPluginException': 'Dependency Error',
//     'NoSuchMethodError': 'Logic Error',
//     'TimeoutException': 'Performance Issue',
//     'DatabaseException': 'Database Error',
//     'RenderFlex': 'UI/Layout Issue'
//   };

//   static const Map<String, int> _basePriorities = {
//     'Network Error': 3,
//     'Dependency Error': 2,
//     'Logic Error': 2,
//     'Performance Issue': 3,
//     'Database Error': 3,
//     'UI/Layout Issue': 1
//   };

//   String categorizeError(String errorMessage) {
//     for (final entry in _errorPatterns.entries) {
//       if (errorMessage.contains(entry.key)) {
//         return entry.value;
//       }
//     }
//     return 'Unknown Error';
//   }

//   int assignPriority(String category, bool isCritical, int frequency) {
//     final basePriority = _basePriorities[category] ?? 1;
//     final criticalityFactor = isCritical ? 2 : 1;
//     final frequencyFactor = frequency > 5 ? 2 : 1;

//     return basePriority * criticalityFactor * frequencyFactor;
//   }

//   void processError(dynamic error, StackTrace stackTrace) {
//     final chain = Chain.forTrace(stackTrace);
//     final trace = chain.terse;
//     print('Error category: ${categorizeError(error.toString())}');
//     print('Stack trace:\n$trace');
//   }
// }
