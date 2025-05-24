import 'package:equatable/equatable.dart';

class CurrentErrorDetails extends Equatable {
  const CurrentErrorDetails({
    required this.id,
    required this.rootCauseName,
    required this.rootCauseLineNumber,
    required this.stackTrace,
    this.surroundingCode,
    this.humanDescription,
    this.additionalInfo,
  });

  final String id;
  final String rootCauseName;
  final String rootCauseLineNumber;
  final String stackTrace;
  final String? surroundingCode;
  final String? humanDescription;
  final Map<String, String>? additionalInfo;

  @override
  List<Object?> get props => [
        id,
        rootCauseName,
        rootCauseLineNumber,
        stackTrace,
        surroundingCode,
        humanDescription,
        additionalInfo,
      ];
}


/*
 
*/

// error_severity.dart
enum ErrorSeverity {
  critical, // Application crashes, data loss
  error, // Feature failures, but app continues
  warning, // Non-critical issues that need attention
  info // Informational logs
}

// error_category.dart
enum ErrorCategory {
  network, // API calls, connectivity issues
  database, // Local storage, data persistence
  auth, // Authentication related
  ui, // Widget errors, rendering issues
  business, // Business logic violations
  performance, // Performance related issues
  security, // Security related issues
  config, // Configuration related errors
  external, // Third-party integrations
  unknown // Uncategorized errors
}

// error_log_model.dart
class ErrorLog {
  ErrorLog({
    required this.errorMessage,
    required this.timestamp,
    required this.severity,
    required this.category,
    this.stackTrace,
    this.os,
    this.deviceModel,
    this.platform,
    this.screenResolution,
    this.appVersion,
    this.flutterVersion,
    this.dartVersion,
    this.buildMode,
    this.userId,
    this.sessionId,
    this.userActivity,
    this.debugLogs,
    this.apiDetails,
    this.networkConnectivity,
    this.networkType,
    this.currentScreen,
    this.navigationHistory,
    this.widgetState,
    this.customData,
  });
  final String errorMessage;
  final String timestamp;
  final ErrorSeverity severity;
  final ErrorCategory category;

  // System Info
  final String? os;
  final String? deviceModel;
  final String? platform;
  final String? screenResolution;

  // App Info
  final String? appVersion;
  final String? flutterVersion;
  final String? dartVersion;
  final String? buildMode;

  // User Context
  final String? userId;
  final String? sessionId;
  final String? userActivity;

  // Debug Info
  final String? stackTrace;
  final List<String>? debugLogs;

  // Network Info
  final String? apiDetails;
  final String? networkConnectivity;
  final String? networkType;

  // Navigation Context
  final String? currentScreen;
  final List<String>? navigationHistory;

  // State Info
  final Map<String, dynamic>? widgetState;
  final Map<String, dynamic>? customData;

  Map<String, dynamic> toJson() {
    return {
      'errorMessage': errorMessage,
      'timestamp': timestamp,
      'severity': severity.toString(),
      'category': category.toString(),
      'stackTrace': stackTrace,
      'systemInfo': {
        'os': os,
        'deviceModel': deviceModel,
        'platform': platform,
        'screenResolution': screenResolution,
      },
      'appInfo': {
        'appVersion': appVersion,
        'flutterVersion': flutterVersion,
        'dartVersion': dartVersion,
        'buildMode': buildMode,
      },
      'userContext': {
        'userId': userId,
        'sessionId': sessionId,
        'userActivity': userActivity,
      },
      'debugInfo': {
        'debugLogs': debugLogs,
      },
      'networkInfo': {
        'apiDetails': apiDetails,
        'networkConnectivity': networkConnectivity,
        'networkType': networkType,
      },
      'navigationContext': {
        'currentScreen': currentScreen,
        'navigationHistory': navigationHistory,
      },
      'stateInfo': {
        'widgetState': widgetState,
        'customData': customData,
      },
    };
  }
}

// error_logger.dart
class ErrorLogger {
  factory ErrorLogger() {
    return _instance;
  }

  ErrorLogger._internal();
  static final ErrorLogger _instance = ErrorLogger._internal();

  Future<void> logError({
    required String message,
    required ErrorSeverity severity,
    required ErrorCategory category,
    String? stackTrace,
    Map<String, dynamic>? additionalInfo,
  }) async {
    final errorLog = ErrorLog(
      errorMessage: message,
      timestamp: DateTime.now().toIso8601String(),
      severity: severity,
      category: category,
      stackTrace: stackTrace,
      // Add system info
      os: await _getOperatingSystem(),
      deviceModel: await _getDeviceModel(),
      // Add other fields as needed
    );

    await _persistError(errorLog);
    await _notifyError(errorLog);
  }

  Future<String> _getOperatingSystem() async {
    // Implementation to get OS info
    return 'Unknown';
  }

  Future<String> _getDeviceModel() async {
    // Implementation to get device model
    return 'Unknown';
  }

  Future<void> _persistError(ErrorLog error) async {
    // Implement error persistence logic
    // This could be local storage, remote logging service, etc.
  }

  Future<void> _notifyError(ErrorLog error) async {
    // Implement error notification logic
    // This could be crash reporting service, analytics, etc.
  }
}

// Usage Example:
void main() {
  final errorLogger = ErrorLogger();

  try {
    // Some code that might throw an error
  } catch (e, stackTrace) {
    errorLogger.logError(
      message: e.toString(),
      severity: ErrorSeverity.error,
      category: ErrorCategory.network,
      stackTrace: stackTrace.toString(),
      additionalInfo: {
        'customField': 'value',
      },
    );
  }
}

/*




1. Choose the task & do i need to
2. Create System for this
3. Best way to do this and search with Ai
4. Do it mind and Do it with Ai
5. Start action


Active Framework -- 
select from Framework Library



Industry experts typically follow these stages in pre-development, each building upon the previous:

1. Understanding Stage
- Project goals
- Core features
- User needs
- Limitations/constraints

2. Visual Planning Stage
- Basic wireframes
- Screen flows
- Navigation maps
- Component layouts

3. Technical Deep-Dive Stage
- Deep component analysis
   * How each component works
   * What data it needs 
   * How it handles states
   * Error scenarios
- Data requirements
- Performance considerations

4. Architecture Planning Stage 
- Project structure
- Design patterns
- Code organization
- Package choices
- Testing approach

5. Development Strategy Stage
- Feature priorities
- Development phases
- Timeline planning
- Resource planning

Key Difference from Standard Stages:
- More focus on component details
- More attention to edge cases
- Deeper technical analysis
- Better risk assessment
- Clear implementation path

Would you like me to elaborate on how experts approach any particular stage?



3. Steps in the Technical Deep-Dive Stage
Deep Component Analysis

For each UI component (e.g., buttons, collapsible panels, 
framework cards), determine:

Purpose: What does the component do?
Data Needs: What data does it require or display?

Interactions: How does the user interact with it? 
What happens on a click, drag, or hover?

State Handling: What are the possible states 
(e.g., active, inactive, loading)?


Error and Edge Cases

Consider situations like:
What if there’s no data to display in the framework collection?
What if the user loses network connectivity while editing or saving?
How to handle invalid inputs when creating a new framework?
Data Requirements

Identify what data will be needed for each feature and component.
Example: The Framework Library will need:
Framework ID, name, and timestamp for display.
Methods to fetch, add, edit, and delete frameworks from storage.
Performance Considerations

Plan how to keep the app responsive:
Should loading indicators be shown while fetching data?
Will framework data be cached for quicker navigation?
Backend/API Requirements

Define the API endpoints or backend logic required to support the app:
Example:
GET /frameworks → Fetch all frameworks
POST /frameworks → Add a new framework
DELETE /framework/{id} → Delete a framework
Storage Requirements

Decide how data will be stored 
(e.g., locally using SQLite, shared preferences, 
or in a remote database like Firebase).

Next Steps
Go through the visual plan and analyze each component technically.
Document the requirements for data, states, and interactions.
Define any APIs or backend processes needed to support the app.
List out any potential edge cases or error scenarios and plan their handling.









































































*/
