import 'package:debug_app_web/core/constants/build.dart';
import 'package:debug_app_web/core/di/depandency_injection.dart';
import 'package:debug_app_web/core/services/loading_toast_service.dart';
import 'package:debug_app_web/core/services/toast_service.dart';
import 'package:debug_app_web/core/widgets/atoms/display/app_header_widget.dart';
import 'package:debug_app_web/core/widgets/atoms/display/app_svg_icon_widget.dart';
import 'package:debug_app_web/core/widgets/atoms/inputs/app_dropdown_widget.dart';
import 'package:debug_app_web/core/widgets/molecules/feedback/progress_indicator_widget.dart';
import 'package:debug_app_web/features/setting/workspace/cubit/appearance_cubit.dart';
import 'package:debug_app_web/features/setting/workspace/cubit/apperence_state.dart';
import 'package:debug_app_web/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:theme_ui_widgets/app_theme.dart';

class ThemeSelectionWidget extends HookWidget {
  const ThemeSelectionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    useDebugRebuildTracker(
      'ThemeSelectionWidget',
      customLogThreshold: 1,
      customWarningThreshold: 3,
    );

    // 🎯 SOLUTION: Move hooks outside BlocBuilder to main build method
    final rebuildTracker = useState<int>(0);
    final loadingService = sl<LoadingToastService>();
    final cubit = context.read<AppearanceCubit>();

    

    // 🎯 SOLUTION: Use BlocBuilder with buildWhen to control rebuilds
    return BlocBuilder<AppearanceCubit, AppearanceState>(
      buildWhen: (previous, current) {
        // Only rebuild when theme-related fields change
        return previous.availableThemes != current.availableThemes ||
            previous.appThemeSet.themeName != current.appThemeSet.themeName ||
            previous.errorMessage != current.errorMessage ||
            previous.isLoading != current.isLoading;
      },
      builder: (context, state) {
        final theme = AppTheme.of(context);

        void handleThemeDelete(String themeName) {
          cubit.deleteTheme(themeName).then((_) {
            // it rebuild the screen to refresh the theme list
            rebuildTracker.value++;
          });
        }

        // Handle theme upload with toastification loading
        Future<void> handleThemeUpload() async {
          try {
            // 1. Show loading indicator
            loadingService.show(
              context,
              initialMessage: 'Uploading theme...',
              child: const ProgressIndicatorWidget(
                message: 'Uploading theme...',
                progress: 0,
              ),
            );

            // Simulate progress for demonstration
            await Future<void>.delayed(const Duration(milliseconds: 500));
            loadingService.update(progress: 0.5, message: 'Processing...');

            // 2. Actual upload operation
            await cubit.uploadTheme();

            // it check if there is no error message then it will not show the success message
            if (state.errorMessage != null) {
              await Future<void>.delayed(const Duration(milliseconds: 100));
              loadingService.hide();
              return;
            }

            // 3. Update to complete
            loadingService.update(progress: 1, message: 'Upload complete!');
            await Future<void>.delayed(const Duration(milliseconds: 500));

            // it rebuild the screen to refresh the theme list
            rebuildTracker.value++;
          } on Exception catch (_) {
            // show error toast if something went wrong
            sl<ToastService>().showErrorToast(
              title: 'Error',
              description: state.errorMessage,
            );
          } finally {
            loadingService.hide();
          }
        }

        final themeItems = state.availableThemes
            .map(
              (themeEntity) => SimpleDropdownItem<bool>(
                themeEntity.themeName,
                themeEntity.isInbuilt,
                suffixIcon: themeEntity.isInbuilt
                    ? null
                    : Row(
                        children: [
                          if (state.appThemeSet.themeName == themeEntity.themeName)
                            Icon(
                              Icons.check,
                              size: 24,
                              color: theme.iconColorScheme.primary,
                            )
                          else
                            const SizedBox.shrink(),
                          SizedBox(width: theme.spacing.s),
                          GestureDetector(
                            onTap: () {
                              handleThemeDelete(themeEntity.themeName);
                            },
                            child: Icon(
                              Icons.delete,
                              size: 24,
                              color: theme.iconColorScheme.primary,
                            ),
                          ),
                        ],
                      ),
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
                  child: AppDropDownWidget<bool>(
                    key: ValueKey(
                      'dropdown_${state.availableThemes.length}_${rebuildTracker.value}',
                    ), // 🔧 Force rebuild with value key
                    height: 75,
                    items: themeItems,
                    selectedValue: state.appThemeSet.themeName,
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
                    final firstInbuiltTheme = state.availableThemes
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
      },
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
    // Note: This widget is small and only rebuilds when its parent rebuilds,
    // so theme access optimization is less critical here
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
