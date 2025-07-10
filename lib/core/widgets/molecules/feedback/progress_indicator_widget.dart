import 'package:debug_app_web/core/widgets/atoms/loading/global_loading_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:theme_ui_widgets/app_theme.dart';

/// A reusable widget for displaying progress with a spinner, message,
/// and a determinate progress bar.
class ProgressIndicatorWidget extends HookWidget {
  const ProgressIndicatorWidget({
    required this.message,
    required this.progress,
    super.key,
  });

  final String message;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    print('progress: $progress');
    return AnimatedFileUploadDialog(
      fileName: message,
      progress: progress,
    );
  }
}
