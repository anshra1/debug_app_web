import 'package:debug_app_web/core/di/depandency_injection.dart';
import 'package:debug_app_web/core/widgets/atoms/display/app_header_widget.dart';
import 'package:debug_app_web/core/widgets/atoms/display/app_svg_icon_widget.dart';
import 'package:debug_app_web/core/widgets/atoms/inputs/app_drop_down_widget.dart';
import 'package:debug_app_web/features/setting/workspace/cubit/appearance_cubit.dart';
import 'package:debug_app_web/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:theme_ui_widgets/theme/app_theme.dart';
import 'package:toastification/toastification.dart';

class ThemeSelectionWidget extends HookWidget {
  const ThemeSelectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);
    final cubit = context.read<AppearanceCubit>();
    final toastification = sl<Toastification>();
    final rebuildTracker = useState<int>(0);

    void handleThemeDelete(String themeName) {
      cubit.deleteTheme(themeName).then((_) {
        rebuildTracker.value++;
      });
    }

    // Handle theme upload with toastification loading
    Future<void> handleThemeUpload() async {
      try {
        // Create a ValueNotifier to track progress
        final progressNotifier = ValueNotifier<double>(0);
        final messageNotifier = ValueNotifier<String>('Uploading theme...');

        // Show single loading toast that will update based on notifiers
        toastification.showCustom(
          context: context,
          config: const ToastificationConfig(
            blockBackgroundInteraction: true, // Modal behavior
            alignment: Alignment.center, // Center on screen
            margin: EdgeInsets.all(20),
          ),
          builder: (context, item) => ValueListenableBuilder<double>(
            valueListenable: progressNotifier,
            builder: (context, progress, child) {
              return ValueListenableBuilder<String>(
                valueListenable: messageNotifier,
                builder: (context, message, child) {
                  return _ToastProgressWidget(
                    message: message,
                    progress: progress,
                  );
                },
              );
            },
          ),
        );

        // Simulate progress for demonstration - Update to 0.5
        await Future<void>.delayed(const Duration(milliseconds: 300));
        progressNotifier.value = 0.5;

        // Actual upload operation
        await cubit.uploadTheme();

        // Update progress to 1.0 (completed)
        progressNotifier.value = 1.0;
        messageNotifier.value = 'Upload complete!';

        // Brief delay to show completion
        await Future<void>.delayed(const Duration(milliseconds: 500));

        // Dismiss loading toast
        toastification.dismissAll();

        // Dispose notifiers
        progressNotifier.dispose();
        messageNotifier.dispose();

        // Show success toast
        toastification.show(
          config: const ToastificationConfig(
            alignment: Alignment.topRight,
            margin: EdgeInsets.all(16),
          ),
          title: const Text('✅ Theme uploaded successfully!'),
          description: const Text('Your custom theme is now available'),
          type: ToastificationType.success,
          autoCloseDuration: const Duration(seconds: 3),
        );

        rebuildTracker.value++;
      } on Exception catch (e) {
        // Dismiss loading toast if still showing
        toastification
          ..dismissAll()

          // Show error toast
          ..show(
            config: const ToastificationConfig(
              alignment: Alignment.center,
              blockBackgroundInteraction: true, // Modal error
              itemWidth: 450,
              margin: EdgeInsets.all(20),
            ),
            title: const Text('❌ Upload Failed'),
            description: Text('Error: $e'),
            type: ToastificationType.error,
            autoCloseDuration: const Duration(seconds: 8),
          );

        // Error is already handled by the cubit
        debugPrint('Theme upload error: $e');
      }
    }

    final themeItems = cubit.state.availableThemes
        .map(
          (themeEntity) => SimpleDropdownItem<bool>(
            themeEntity.themeName,
            themeEntity.isInbuilt,
            suffixIcon: themeEntity.isInbuilt
                ? null
                : Row(
                    children: [
                      if (cubit.state.appThemeSet.themeName == themeEntity.themeName)
                        Icon(
                          Icons.check,
                          size: 20,
                          color: theme.iconColorScheme.primary,
                        )
                      else
                        const SizedBox.shrink(),
                      SizedBox(width: theme.spacing.s),
                      Icon(
                        Icons.delete,
                        size: 20,
                        color: theme.iconColorScheme.primary,
                      ),
                    ],
                  ),
            onSuffixIconTap: () {
              // 🔧 Use live delete handler instead of direct cubit call
              handleThemeDelete(themeEntity.themeName);
            },
          ),
        )
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppHeaderWidget(
          title: 'Workspace Theme',
        ),
        SizedBox(height: theme.spacing.l),
        Row(
          children: [
            // 90% - Theme Dropdown
            Expanded(
              flex: 9,
              child: AppDrownDownWidget<bool>(
                key: ValueKey(
                  'dropdown_${cubit.state.availableThemes.length}_${rebuildTracker.value}',
                ), // 🔧 Force rebuild with value key
                height: 75,
                items: themeItems,
                selectedValue: cubit.state.appThemeSet.themeName,
                onChanged: (item) => cubit.setTheme(item?.label ?? ''),
                hint: 'Select theme...',
                config: AppDropdownWidgetConfig.defaultConfig(context),
              ),
            ),
            SizedBox(width: theme.spacing.m),

            // Folder icon with toastification loading
            Container(
              height: 75,
              width: 75,
              decoration: BoxDecoration(
                border: Border.all(color: theme.borderColorScheme.primary),
                borderRadius: BorderRadius.circular(theme.borderRadius.m),
                color: Colors.transparent,
              ),
              child: AppSvgIcon(
                assetPath: Assets.icons.folder,
                config: AppSvgIconConfig.folderIconConfig(context).copyWith(size: 36),
                onTap: handleThemeUpload,
                tooltip: 'Upload a custom theme',
                semanticLabel: 'Browse theme files',
              ),
            ),
            const SizedBox(width: 10),
            // Reset Button
            _ResetThemeButton(
              onReset: () {
                final firstInbuiltTheme = cubit.state.availableThemes
                    .where((theme) => theme.isInbuilt)
                    .firstOrNull;
                if (firstInbuiltTheme != null) {
                  cubit.setTheme(firstInbuiltTheme.themeName);
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}

/// Progress loading widget with progress bar
class _ToastProgressWidget extends StatelessWidget {
  const _ToastProgressWidget({
    required this.message,
    required this.progress,
  });

  final String message;
  final double progress;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.borderColorScheme.primary),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Loading spinner
          SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              color: theme.iconColorScheme.primary,
            ),
          ),

          const SizedBox(height: 16),

          // Message
          Text(
            message,
            style: theme.textStyle.labelLarge.prominent(
              context: context,
              color: theme.textColorScheme.primary,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 12),

          // Progress bar
          SizedBox(
            width: 250,
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation(theme.iconColorScheme.primary),
              minHeight: 6,
            ),
          ),

          const SizedBox(height: 8),

          // Progress percentage
          Text(
            '${(progress * 100).toInt()}%',
            style: theme.textStyle.labelSmall.prominent(
              context: context,
              color: theme.textColorScheme.secondary,
            ),
          ),
        ],
      ),
    );
  }
}

/// Reset theme button
class _ResetThemeButton extends StatelessWidget {
  const _ResetThemeButton({
    required this.onReset,
  });

  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    return GestureDetector(
      onTap: onReset,
      child: Container(
        height: 75,
        width: 120,
        padding: EdgeInsets.symmetric(
          horizontal: theme.spacing.s,
          vertical: theme.spacing.s,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: theme.borderColorScheme.primary),
          borderRadius: BorderRadius.circular(theme.borderRadius.m),
          color: Colors.transparent,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.refresh,
              size: 24,
              color: theme.iconColorScheme.primary,
            ),
            SizedBox(
              width: theme.spacing.s,
            ),
            Text(
              'Reset',
              style: theme.textStyle.labelMedium.prominent(
                context: context,
                color: theme.textColorScheme.primary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
