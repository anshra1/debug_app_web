import 'package:debug_app_web/core/widgets/molecules/feedback/progress_indicator_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:toastification/toastification.dart';

/// @component LoadingService
/// @category Service
/// @created 2024-03-19
/// @lastModified 2024-03-19
///
/// @description
/// A service that manages loading notifications in the application.
/// Provides functionality to show, update, and hide loading indicators with messages
/// and progress updates. Ensures only one loading indicator is displayed at a time.
///
/// @initialization
/// ```dart
/// // Through dependency injection
/// final loadingService = sl<LoadingService>();
/// ```
///
/// @How to use
/// ```dart
/// final loadingService = sl<LoadingService>();
///
/// try {
///   loadingService.show(
///     context,
///     child: ProgressIndicatorWidget(),
///     initialMessage: 'Loading data...'
///   );
///   // Perform async work
///   loadingService.update(message: 'Processing...', progress: 0.5);
///   // More work
/// } finally {
///   loadingService.hide();
/// }
/// ```
///
/// @method
/// - show(): Displays a loading indicator with custom widget and optional auto-close duration
/// - update(): Updates the current loading indicator's message and/or progress
/// - hide(): Dismisses the current loading indicator
/// - isShowing: Getter that returns whether a loading indicator is currently displayed
///
/// @dispose
/// No manual disposal needed. Service manages its own state cleanup.
///
/// @important
/// - Only one loading indicator can be shown at a time
/// - show() and hide() must be called in pairs
/// - Always call hide() in a finally block to ensure cleanup
/// - Service must be accessed through dependency injection
///
/// @errors
/// - Calling update() when no loading indicator is showing will be ignored
/// - Multiple show() calls will update the existing indicator instead of creating new ones
///
/// @testing
/// Test file not found
/// Expected location: test/core/services/loading_toast_service_test.dart
///
/// @relatedComponents
/// - ProgressIndicatorWidget: Special handling for progress updates and message display
/// - Toastification: Underlying notification system
/// - ValueNotifier: State management for loading indicator data

class LoadingService {
  LoadingService({
    required Toastification toastification,
    required ValueNotifier<(String message, double progress)> dataNotifier,
  })  : _toastification = toastification,
        _dataNotifier = dataNotifier;

  final Toastification _toastification;

  final ValueNotifier<(String message, double progress)> _dataNotifier;

  ToastificationItem? _toastItem;

  bool get isShowing => _toastItem != null;

  void show(
    BuildContext context, {
    required Widget child,
    Duration? autoCloseDuration,
    String initialMessage = 'Loading...',
  }) {
    if (_toastItem != null) {
      update(message: initialMessage);
      return;
    }

    _dataNotifier.value = (initialMessage, 0.0);

    _toastItem = toastification.showCustom(
      context: context,
      autoCloseDuration: autoCloseDuration ?? const Duration(seconds: 12),
      config: const ToastificationConfig(
        blockBackgroundInteraction: true,
        alignment: Alignment.center,
      ),
      builder: (context, item) {
        return _LoadingWidget(
          dataNotifier: _dataNotifier,
          child: child,
        );
      },
    );
  }

  void update({String? message, double? progress}) {
    if (_toastItem == null) return;

    if (message != null && progress != null) {
      _dataNotifier.value = (message, progress);
    }
  }

  void hide() {
    if (_toastItem != null) {
      _toastification.dismiss(_toastItem!);
      _toastItem = null;
    }
  }
}

class _LoadingWidget extends HookWidget {
  const _LoadingWidget({
    required this.dataNotifier,
    required this.child,
  });

  final ValueNotifier<(String message, double progress)> dataNotifier;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final data = useValueListenable(dataNotifier);

    if (child is ProgressIndicatorWidget) {
      return ProgressIndicatorWidget(
        message: data.$1,
        progress: data.$2,
      );
    }

    return child;
  }
}
