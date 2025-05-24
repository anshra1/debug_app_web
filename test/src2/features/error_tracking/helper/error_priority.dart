// import 'package:debug_app_web/src/cores/enum/enum.dart';
// import 'package:debug_app_web/src/features/error_tracking/helper/error_categories.dart';
// import 'package:logging/logging.dart';

// /// A service responsible for handling and prioritizing errors in the application.
// class ErrorPriorityHandler {
//   static final _logger = Logger('ErrorPriorityHandler');
  
//   /// Determines error priority based on category, error details, and context
//   static ErrorPriority determineErrorPriority({
//     required DebugErrorCategory category,
//     required dynamic error,
//     required StackTrace stackTrace,
//     Map<String, dynamic>? context,
//   }) {
//     try {
//       // Log the incoming error for debugging and monitoring
//       _logger.fine('Determining priority for error: ${error.toString().substring(0, Math.min(100, error.toString().length))}');
      
//       // First check for critical patterns that override category-based priority
//       if (_containsCriticalPatterns(
//         errorStr: error.toString(), 
//         stackTraceStr: stackTrace.toString(),
//         context: context,
//       )) {
//         _logger.warning('Critical pattern detected in error');
//         return ErrorPriority.fatal;
//       }

//       // Use a more maintainable priority mapping approach
//       final priority = _getPriorityForCategory(category);
      
//       // Apply context-based priority adjustments
//       final adjustedPriority = _adjustPriorityBasedOnContext(
//         basePriority: priority,
//         context: context,
//       );

//       _logger.fine('Determined priority: $adjustedPriority for category: $category');
//       return adjustedPriority;
//     } catch (e, st) {
//       _logger.severe('Error determining priority', e, st);
//       // Default to high priority if priority determination fails
//       return ErrorPriority.high;
//     }
//   }

//   /// Maps error categories to their base priority levels
//   static ErrorPriority _getPriorityForCategory(DebugErrorCategory category) {
//     // Using a more maintainable map structure instead of switch statement
//     final priorityMap = <DebugErrorCategory, ErrorPriority>{
//       // Fatal Priority
//       DebugErrorCategory.SECURITY_AUTHENTICATION: ErrorPriority.fatal,
//       DebugErrorCategory.SECURITY_AUTHORIZATION: ErrorPriority.fatal,
//       DebugErrorCategory.SECURITY_ENCRYPTION: ErrorPriority.fatal,
//       DebugErrorCategory.DATABASE_INTEGRITY: ErrorPriority.fatal,
//       DebugErrorCategory.DATABASE_MIGRATION: ErrorPriority.fatal,
      
//       // High Priority
//       DebugErrorCategory.NETWORK_AUTHENTICATION: ErrorPriority.high,
//       DebugErrorCategory.DATABASE_TRANSACTION: ErrorPriority.high,
//       DebugErrorCategory.STATE_INITIALIZATION: ErrorPriority.high,
//       DebugErrorCategory.PERFORMANCE_MEMORY: ErrorPriority.high,
//       DebugErrorCategory.PERFORMANCE_CPU: ErrorPriority.high,
//       DebugErrorCategory.LIFECYCLE_INITIALIZATION: ErrorPriority.high,
//       DebugErrorCategory.CONFIG_MISSING: ErrorPriority.high,
      
//       // Medium Priority
//       DebugErrorCategory.UI_LAYOUT: ErrorPriority.medium,
//       DebugErrorCategory.NETWORK_TIMEOUT: ErrorPriority.medium,
//       DebugErrorCategory.NETWORK_RESPONSE: ErrorPriority.medium,
//       DebugErrorCategory.DATABASE_QUERY: ErrorPriority.medium,
//       DebugErrorCategory.STATE_UPDATE: ErrorPriority.medium,
//       DebugErrorCategory.INTEGRATION_API: ErrorPriority.medium,
//       DebugErrorCategory.LOGIC_VALIDATION: ErrorPriority.medium,
//       DebugErrorCategory.ASSET_MISSING: ErrorPriority.medium,
      
//       // Low Priority
//       DebugErrorCategory.UI_ANIMATION: ErrorPriority.low,
//       DebugErrorCategory.UI_GESTURE: ErrorPriority.low,
//       DebugErrorCategory.UI_STATE: ErrorPriority.low,
//       DebugErrorCategory.ASSET_FORMAT: ErrorPriority.low,
//       DebugErrorCategory.DEV_DEBUG: ErrorPriority.low,
//       DebugErrorCategory.PLATFORM_WEB: ErrorPriority.low,
//       DebugErrorCategory.INTEGRATION_PLUGIN: ErrorPriority.low,
//     };

//     // Handle previously unimplemented categories with reasonable defaults
//     final priority = priorityMap[category] ?? _getDefaultPriorityForCategory(category);
//     return priority;
//   }

//   /// Provides default priority for previously unimplemented categories
//   static ErrorPriority _getDefaultPriorityForCategory(DebugErrorCategory category) {
//     // Group similar categories and assign appropriate priorities
//     if (category.toString().contains('SECURITY')) {
//       return ErrorPriority.fatal;
//     } else if (category.toString().contains('NETWORK') || 
//                category.toString().contains('DATABASE')) {
//       return ErrorPriority.high;
//     } else if (category.toString().contains('UI') || 
//                category.toString().contains('ASSET')) {
//       return ErrorPriority.medium;
//     }
//     return ErrorPriority.low;
//   }

//   /// Adjusts priority based on additional context
//   static ErrorPriority _adjustPriorityBasedOnContext({
//     required ErrorPriority basePriority,
//     Map<String, dynamic>? context,
//   }) {
//     if (context == null) return basePriority;

//     // Escalate priority for production environment
//     if (context['environment'] == 'production') {
//       return _escalatePriority(basePriority);
//     }

//     // Escalate for high-impact users or critical business functions
//     if (context['userType'] == 'premium' || 
//         context['isBusinessCritical'] == true) {
//       return _escalatePriority(basePriority);
//     }

//     return basePriority;
//   }

//   /// Escalates priority by one level
//   static ErrorPriority _escalatePriority(ErrorPriority current) {
//     switch (current) {
//       case ErrorPriority.low:
//         return ErrorPriority.medium;
//       case ErrorPriority.medium:
//         return ErrorPriority.high;
//       case ErrorPriority.high:
//         return ErrorPriority.fatal;
//       default:
//         return current;
//     }
//   }

//   /// Checks for critical patterns with improved pattern matching
//   static bool _containsCriticalPatterns({
//     required String errorStr,
//     required String stackTraceStr,
//     Map<String, dynamic>? context,
//   }) {
//     final errorLower = errorStr.toLowerCase();
//     final stackLower = stackTraceStr.toLowerCase();

//     // Enhanced pattern matching with categorized critical patterns
//     final criticalPatterns = {
//       'security': [
//         'security breach',
//         'unauthorized access',
//         'sql injection',
//         'xss attack',
//         'data leak',
//         'csrf detected',
//         'authentication bypass',
//       ],
//       'system': [
//         'system crash',
//         'fatal exception',
//         'out of memory',
//         'stack overflow',
//         'deadlock detected',
//         'system halt',
//         'kernel panic',
//       ],
//       'data': [
//         'data corruption',
//         'database crash',
//         'data loss',
//         'integrity violation',
//         'transaction rollback',
//         'consistency violation',
//       ],
//     };

//     // Check each category of patterns
//     for (final patterns in criticalPatterns.values) {
//       if (_containsAny(errorLower, patterns)) return true;
//     }

//     // Consider context for additional critical conditions
//     if (context != null) {
//       if (context['criticalService'] == true || 
         
//           context['userCount'] != null && context['userCount'] > 1000) {
//         return true;
//       }
//     }

//     return false;
//   }

//   /// Improved helper method for pattern matching
//   static bool _containsAny(String source, List<String> patterns) {
//     return patterns.any((pattern) => source.contains(pattern));
//   }
// }

// /// Immutable error class with enhanced metadata support
// class CategoryError implements Exception {
//   const CategoryError({
//     required this.message,
//     required this.category,
//     required this.priority,
//     this.originalError,
//     this.stackTrace,
//     this.metadata,
//     DateTime? timestamp,
//   }) : _timestamp = timestamp ?? DateTime.now();

//   final String message;
//   final DebugErrorCategory category;
//   final ErrorPriority priority;
//   final dynamic originalError;
//   final StackTrace? stackTrace;
//   final Map<String, dynamic>? metadata;
//   final DateTime _timestamp;

//   DateTime get timestamp => _timestamp;

//   @override
//   String toString() => 'CategoryError: $message '
//       '(Category: $category, Priority: $priority, '
//       'Timestamp: ${_timestamp.toIso8601String()})';

//   Map<String, dynamic> toJson() => {
//         'message': message,
//         'category': category.toString(),
//         'priority': priority.toString(),
//         'timestamp': _timestamp.toIso8601String(),
//         'metadata': metadata,
//         'stackTrace': stackTrace?.toString(),
//         'originalError': originalError?.toString(),
//       };

//   CategoryError copyWith({
//     String? message,
//     DebugErrorCategory? category,
//     ErrorPriority? priority,
//     dynamic originalError,
//     StackTrace? stackTrace,
//     Map<String, dynamic>? metadata,
//     DateTime? timestamp,
//   }) {
//     return CategoryError(
//       message: message ?? this.message,
//       category: category ?? this.category,
//       priority: priority ?? this.priority,
//       originalError: originalError ?? this.originalError,
//       stackTrace: stackTrace ?? this.stackTrace,
//       metadata: metadata ?? this.metadata,
//       timestamp: timestamp ?? _timestamp,
//     );
//   }
// }

// /// Enhanced mixin for error categorization with context support
// mixin ErrorCategorizationMixin {
//   CategoryError categorizeError(
//     Object error,
//     StackTrace stackTrace, {
//     Map<String, dynamic>? context,
//   }) {
//     final category = ErrorCategorizer.categorizeError(error, stackTrace);
//     final priority = ErrorPriorityHandler.determineErrorPriority(
//       category: category,
//       error: error,
//       stackTrace: stackTrace,
//       context: context,
//     );

//     return CategoryError(
//       message: error.toString(),
//       category: category,
//       priority: priority,
//       originalError: error,
//       stackTrace: stackTrace,
//       metadata: context,
//     );
//   }
// }