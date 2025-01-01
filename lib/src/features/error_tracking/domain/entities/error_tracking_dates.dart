import 'package:debug_app_web/src/features/error_tracking/domain/entities/entity_keys.dart';
import 'package:equatable/equatable.dart';

class ErrorTrackingDates extends Equatable {
  const ErrorTrackingDates({
    required this.created,
    required this.modified,
    required this.lastOccurrence,
  });

  factory ErrorTrackingDates.fromJson(Map<String, dynamic> json) => ErrorTrackingDates(
        created: DateTime.parse(
          json[EntityKeys.created] as String? ?? DateTime.now().toIso8601String(),
        ),
        modified: json[EntityKeys.modified] != null
            ? DateTime.parse(json[EntityKeys.modified] as String)
            : null,
        lastOccurrence: DateTime.parse(
          json[EntityKeys.lastOccurrence] as String? ?? DateTime.now().toIso8601String(),
        ),
      );

  final DateTime? created;
  final DateTime? modified;
  final DateTime lastOccurrence;

  Map<String, dynamic> toJson() => {
        EntityKeys.created: created?.toIso8601String(),
        if (modified != null) EntityKeys.modified: modified?.toIso8601String(),
        EntityKeys.lastOccurrence: lastOccurrence.toIso8601String(),
      };

  ErrorTrackingDates copyWith({
    DateTime? created,
    DateTime? modified,
    DateTime? lastOccurrence,
  }) {
    return ErrorTrackingDates(
      created: created ?? this.created,
      modified: modified ?? this.modified,
      lastOccurrence: lastOccurrence ?? this.lastOccurrence,
    );
  }

  @override
  List<Object?> get props => [created, modified, lastOccurrence];
}
