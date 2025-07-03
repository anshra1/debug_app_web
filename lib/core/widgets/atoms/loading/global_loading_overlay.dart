import 'package:debug_app_web/core/services/loading_service.dart';
import 'package:debug_app_web/core/utils/extensions/context.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class GlobalLoadingOverlay extends HookWidget {
  const GlobalLoadingOverlay({
    required this.state,
    super.key,
    this.onCancel,
  });
  final LoadingState state;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final animationController = useAnimationController(
      duration: const Duration(milliseconds: 300),
    );

    useEffect(
      () {
        animationController.forward();
        return null; // useAnimationController handles disposal automatically
      },
      [],
    );

    return Material(
      type: MaterialType.transparency,
      child: AnimatedBuilder(
        animation: animationController,
        builder: (context, child) {
          return Opacity(
            opacity: animationController.value,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Colors.black.withOpacity(0.5),
              child: Center(
                child: _LoadingCard(
                  state: state,
                  onCancel: onCancel,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard({
    required this.state,
    this.onCancel,
  });
  final LoadingState state;
  final VoidCallback? onCancel;

  @override
  Widget build(BuildContext context) {
    final appTheme = context.appTheme;
    final background = appTheme.backgroundColorScheme;
    final text = appTheme.textColorScheme;
    final fill = appTheme.fillColorScheme;
    final theme = Theme.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.symmetric(horizontal: 32),
      constraints: const BoxConstraints(
        minWidth: 200,
        maxWidth: 400,
      ),
      decoration: BoxDecoration(
        color: background.primary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Loading Indicator
          _buildLoadingIndicator(context),

          const SizedBox(height: 16),

          // Message
          ...[
            Text(
              state.message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: text.primary,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
          ],

          // Progress Bar (if progress is provided)
          if (state.progress != null) ...[
            _buildProgressBar(context),
            const SizedBox(height: 16),
          ],

          // Cancel Button
          if (state.cancellable && onCancel != null) ...[
            TextButton(
              onPressed: onCancel,
              style: TextButton.styleFrom(
                foregroundColor: text.secondary,
              ),
              child: const Text('Cancel'),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildLoadingIndicator(BuildContext context) {
    final appTheme = context.appTheme;
    final fill = appTheme.fillColorScheme;

    switch (state.type) {
      case LoadingType.network:
        return _AnimatedNetworkIcon(color: fill.themeThick);
      case LoadingType.fileOperation:
        return _AnimatedFileIcon(color: fill.themeThick);
      case LoadingType.upload:
        return _AnimatedUploadIcon(color: fill.themeThick);
      case LoadingType.download:
        return _AnimatedDownloadIcon(color: fill.themeThick);
      case LoadingType.general:
      case LoadingType.navigation:
      default:
        return SizedBox(
          width: 48,
          height: 48,
          child: CircularProgressIndicator(
            strokeWidth: 3,
            valueColor: AlwaysStoppedAnimation<Color>(fill.themeThick),
          ),
        );
    }
  }

  Widget _buildProgressBar(BuildContext context) {
    final appTheme = context.appTheme;
    final text = appTheme.textColorScheme;
    final fill = appTheme.fillColorScheme;
    final progress = state.progress ?? 0.0;

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Progress',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: text.secondary,
                  ),
            ),
            Text(
              '${(progress * 100).round()}%',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: text.secondary,
                  ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: progress,
          backgroundColor: fill.secondary,
          valueColor: AlwaysStoppedAnimation<Color>(fill.themeThick),
        ),
      ],
    );
  }
}

// =============================================================================
// ANIMATED LOADING ICONS
// =============================================================================

class _AnimatedNetworkIcon extends StatefulWidget {
  const _AnimatedNetworkIcon({required this.color});
  final Color color;

  @override
  State<_AnimatedNetworkIcon> createState() => _AnimatedNetworkIconState();
}

class _AnimatedNetworkIconState extends State<_AnimatedNetworkIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.rotate(
            angle: _controller.value * 2 * 3.14159,
            child: Icon(
              Icons.wifi,
              size: 48,
              color: widget.color,
            ),
          );
        },
      ),
    );
  }
}

class _AnimatedFileIcon extends StatefulWidget {
  const _AnimatedFileIcon({required this.color});
  final Color color;

  @override
  State<_AnimatedFileIcon> createState() => _AnimatedFileIconState();
}

class _AnimatedFileIconState extends State<_AnimatedFileIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: 0.5 + 0.5 * (1 + (_controller.value * 2 - 1).abs()),
            child: Icon(
              Icons.folder_open,
              size: 48,
              color: widget.color,
            ),
          );
        },
      ),
    );
  }
}

class _AnimatedUploadIcon extends StatefulWidget {
  const _AnimatedUploadIcon({required this.color});
  final Color color;

  @override
  State<_AnimatedUploadIcon> createState() => _AnimatedUploadIconState();
}

class _AnimatedUploadIconState extends State<_AnimatedUploadIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, -8 * _controller.value),
            child: Icon(
              Icons.cloud_upload,
              size: 48,
              color: widget.color,
            ),
          );
        },
      ),
    );
  }
}

class _AnimatedDownloadIcon extends StatefulWidget {
  const _AnimatedDownloadIcon({required this.color});
  final Color color;

  @override
  State<_AnimatedDownloadIcon> createState() => _AnimatedDownloadIconState();
}

class _AnimatedDownloadIconState extends State<_AnimatedDownloadIcon>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      height: 48,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Transform.translate(
            offset: Offset(0, 8 * _controller.value),
            child: Icon(
              Icons.cloud_download,
              size: 48,
              color: widget.color,
            ),
          );
        },
      ),
    );
  }
}
