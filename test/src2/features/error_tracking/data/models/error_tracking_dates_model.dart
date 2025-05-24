import '../../domain/entities/entity_keys.dart';
import '../../domain/entities/error_tracking_dates.dart';

class ErrorTrackingDatesModel extends ErrorTrackingDates {
  const ErrorTrackingDatesModel({
    required super.created,
    required super.modified,
    required super.lastOccurrence,
  });

  factory ErrorTrackingDatesModel.fromJson(Map<String, dynamic> json) =>
      ErrorTrackingDatesModel(
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

  Map<String, dynamic> toJson() => {
        EntityKeys.created: created?.toIso8601String(),
        if (modified != null) EntityKeys.modified: modified?.toIso8601String(),
        EntityKeys.lastOccurrence: lastOccurrence.toIso8601String(),
      };

  ErrorTrackingDatesModel copyWith({
    DateTime? created,
    DateTime? modified,
    DateTime? lastOccurrence,
  }) {
    return ErrorTrackingDatesModel(
      created: created ?? this.created,
      modified: modified ?? this.modified,
      lastOccurrence: lastOccurrence ?? this.lastOccurrence,
    );
  }

  ErrorTrackingDatesModel copy() {
    return ErrorTrackingDatesModel(
      created: created,
      modified: modified,
      lastOccurrence: lastOccurrence,
    );
  }

  @override
  List<Object?> get props => [created, modified, lastOccurrence];
}
