import 'package:intl/intl.dart';

/// Enum representing different date format options
enum DateFormatType {
  local(pattern: 'MM/dd/yyyy', label: 'Local'), // MM/dd/yyyy
  us(pattern: 'yyyy/MM/dd', label: 'US'), // yyyy/MM/dd
  iso(pattern: 'yyyy-MM-dd', label: 'ISO'), // yyyy-MM-dd
  friendly(pattern: 'MMM dd, yyyy', label: 'Friendly'), // MMM dd, yyyy
  dmy(pattern: 'dd/MM/yyyy', label: 'Day/Month/Year'); // dd/MM/yyyy

  const DateFormatType({
    required this.pattern,
    required this.label,
  });

  final String pattern;
  final String label;
}

/// Enum representing different time format options
enum TimeFormatType {
  twelveHour(pattern: 'hh:mm a', label: '12 Hour'), // 12-hour format with AM/PM
  twentyFourHour(pattern: 'HH:mm', label: '24 Hour'); // 24-hour format

  const TimeFormatType({
    required this.pattern,
    required this.label,
  });

  final String pattern;
  final String label;
}

/// Extension to add date formatting capabilities
extension DateFormatting on DateTime {
  /// Format the date according to the given format type
  String format(DateFormatType formatType) {
    return DateFormat(formatType.pattern).format(this);
  }

  /// Format the date with time according to the given format type and time format
  String formatWithTime(DateFormatType formatType, TimeFormatType timeFormat) {
    final datePattern = formatType.pattern;
    final timePattern = timeFormat.pattern;
    return DateFormat('$datePattern $timePattern').format(this);
  }
}

/// Extension to add time formatting capabilities
extension TimeFormatting on DateTime {
  /// Format the time according to the given format type
  String formatTime(TimeFormatType formatType) =>
      DateFormat(formatType.pattern).format(this);
}

/// Extension to format DateTime based on AppearanceState settings
extension AppearanceStateFormatting on DateTime {
  String formatForState(String dateFormatLabel, String timeFormatLabel) {
    final dateType = DateFormatType.values.firstWhere(
      (type) => type.label == dateFormatLabel,
      orElse: () => DateFormatType.local,
    );
    final timeType = TimeFormatType.values.firstWhere(
      (type) => type.label == timeFormatLabel,
      orElse: () => TimeFormatType.twelveHour,
    );
    return formatWithTime(dateType, timeType);
  }
}
