import 'package:equatable/equatable.dart';

class ErrorTrackingDates extends Equatable {
  const ErrorTrackingDates({
    required this.created,
    required this.modified,
    required this.lastOccurrence,
  });

  final DateTime? created;
  final DateTime? modified;
  final DateTime lastOccurrence;

  @override
  List<Object?> get props => [created, modified, lastOccurrence];
}
