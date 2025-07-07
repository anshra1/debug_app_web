import 'package:flutter/foundation.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// Statistics for a tracked widget
class DebugRebuildStats {
  DebugRebuildStats({
    required this.tag,
    required this.totalBuilds,
    required this.firstBuild,
    required this.lastBuild,
    required this.peakBuildsPerSecond,
    required this.totalTrackingTime,
  });
  final String tag;
  final int totalBuilds;
  final DateTime firstBuild;
  final DateTime lastBuild;
  final int peakBuildsPerSecond;
  final Duration totalTrackingTime;

  double get averageBuildsPerSecond {
    if (totalTrackingTime.inMilliseconds == 0) return 0;
    return totalBuilds / (totalTrackingTime.inMilliseconds / 1000);
  }

  @override
  String toString() {
    return 'DebugRebuildStats(tag: $tag, builds: $totalBuilds, avg: ${averageBuildsPerSecond.toStringAsFixed(2)}/s, peak: $peakBuildsPerSecond/s)';
  }
}

/// Global configuration for DebugRebuildTracker
/// Use DebugRebuildTrackerConfig.enable() / disable() to toggle behavior.
class DebugRebuildTrackerConfig {
  DebugRebuildTrackerConfig._();

  static bool _enabled = true;
  static int _logThreshold = 1; // Log every rebuild by default
  static int _warningThreshold = 10; // Warn when rebuilds exceed this
  static final Map<String, DebugRebuildStats> _statistics = {};

  /// Enable the rebuild tracker globally
  static void enable() {
    _enabled = true;
  }

  /// Disable the rebuild tracker globally
  static void disable() {
    _enabled = false;
  }

  /// Set minimum rebuild count before logging (reduces noise)
  static void setLogThreshold(int threshold) {
    _logThreshold = threshold;
  }

  /// Set rebuild count that triggers warning logs
  static void setWarningThreshold(int threshold) {
    _warningThreshold = threshold;
  }

  /// Reset all statistics
  static void resetStatistics() {
    _statistics.clear();
  }

  /// Reset statistics for specific tag
  static void resetStatisticsFor(String tag) {
    _statistics.remove(tag);
  }

  /// Get statistics for a specific tag
  static DebugRebuildStats? getStatisticsFor(String tag) {
    return _statistics[tag];
  }

  /// Get all collected statistics
  static Map<String, DebugRebuildStats> getAllStatistics() {
    return Map.unmodifiable(_statistics);
  }

  /// Print summary of all tracked widgets
  static void printSummary() {
    if (!kDebugMode || _statistics.isEmpty) return;

    debugPrint('\n=== DebugRebuildTracker Summary ===');
    final sortedStats = _statistics.values.toList()
      ..sort((a, b) => b.totalBuilds.compareTo(a.totalBuilds));

    for (final stat in sortedStats) {
      final warningFlag = stat.totalBuilds > _warningThreshold ? ' ⚠️' : '';
      debugPrint('$stat$warningFlag');
    }

    final topRebuilder = sortedStats.first;
    debugPrint('Most rebuilt: ${topRebuilder.tag} (${topRebuilder.totalBuilds} builds)');
    debugPrint('=====================================\n');
  }

  /// Check if tracker is enabled
  static bool get isEnabled => _enabled;
  static int get logThreshold => _logThreshold;
  static int get warningThreshold => _warningThreshold;

  // Internal method to update statistics
  static void _updateStatistics(String tag, int buildCount, DateTime now) {
    final existing = _statistics[tag];
    if (existing == null) {
      _statistics[tag] = DebugRebuildStats(
        tag: tag,
        totalBuilds: buildCount,
        firstBuild: now,
        lastBuild: now,
        peakBuildsPerSecond: 0,
        totalTrackingTime: Duration.zero,
      );
    } else {
      final timeDiff = now.difference(existing.lastBuild);
      final totalTime = now.difference(existing.firstBuild);

      // Calculate builds per second for this interval
      var buildsPerSecond = 0;
      if (timeDiff.inMilliseconds > 0) {
        buildsPerSecond = (1000 / timeDiff.inMilliseconds).ceil();
      }

      _statistics[tag] = DebugRebuildStats(
        tag: tag,
        totalBuilds: buildCount,
        firstBuild: existing.firstBuild,
        lastBuild: now,
        peakBuildsPerSecond: buildsPerSecond > existing.peakBuildsPerSecond
            ? buildsPerSecond
            : existing.peakBuildsPerSecond,
        totalTrackingTime: totalTime,
      );
    }
  }
}

/// Hook to track how many times a widget rebuilds with a given [tag].
/// Logs rebuild count based on configured thresholds.
/// Only active when:
///   • in debug mode (kDebugMode)
///   • global DebugRebuildTrackerConfig.isEnabled == true
///
/// Example usage: `useDebugRebuildTracker('NewsPreview');`
///
/// Features:
/// - Threshold-based logging to reduce noise
/// - Time-based tracking (rebuilds per second)
/// - Statistics collection and summary reporting
/// - Warning detection for excessive rebuilds
void useDebugRebuildTracker(
  String tag, {
  int? customLogThreshold,
  int? customWarningThreshold,
}) {
  if (!kDebugMode || !DebugRebuildTrackerConfig.isEnabled) return;

  // Use useRef to store counter and timestamp without affecting rebuilds
  final counterRef = useRef<int>(0);
  final timestampRef = useRef<DateTime?>(null);

  // Increment count on each build
  counterRef.value += 1;
  final now = DateTime.now();
  timestampRef.value ??= now;

  // Update statistics
  DebugRebuildTrackerConfig._updateStatistics(tag, counterRef.value, now);

  // Determine thresholds
  final logThreshold = customLogThreshold ?? DebugRebuildTrackerConfig.logThreshold;
  final warningThreshold =
      customWarningThreshold ?? DebugRebuildTrackerConfig.warningThreshold;

  // Log based on threshold
  if (counterRef.value >= logThreshold) {
    final timeSinceStart = now.difference(timestampRef.value!);
    final buildsPerSecond = timeSinceStart.inMilliseconds > 0
        ? (counterRef.value / (timeSinceStart.inMilliseconds / 1000)).toStringAsFixed(2)
        : '0';

    if (counterRef.value >= warningThreshold) {
      debugPrint(
        '⚠️  [DebugRebuildTracker] "$tag" rebuilt ${counterRef.value} times ($buildsPerSecond/s) - Consider optimization!',
      );
    } else {
      debugPrint(
        '📊 [DebugRebuildTracker] "$tag" rebuilt ${counterRef.value} times ($buildsPerSecond/s)',
      );
    }
  }
}

// NOTE: Consider adding these utility extensions for easier usage:
extension DebugRebuildTrackerExtensions on String {
  /// Quick access to reset statistics for this tag
  void resetRebuildStats() => DebugRebuildTrackerConfig.resetStatisticsFor(this);

  /// Get rebuild statistics for this tag
  DebugRebuildStats? getRebuildStats() =>
      DebugRebuildTrackerConfig.getStatisticsFor(this);
}
