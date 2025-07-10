import 'package:debug_app_web/core/widgets/atoms/display/app_header_widget.dart';
import 'package:debug_app_web/core/widgets/atoms/inputs/app_dropdown_widget.dart';
import 'package:debug_app_web/features/setting/workspace/constants/font/font_list.dart';
import 'package:debug_app_web/features/setting/workspace/cubit/appearance_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:theme_ui_widgets/theme/app_theme.dart';

class FontSelectionView extends HookWidget {
  const FontSelectionView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.of(context);

    final fontItems = useMemoized(
      () {
        return fontItemsList;
      },
      [],
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppHeaderWidget(
          title: 'Workspace Font',
        ),
        SizedBox(height: theme.spacing.l),
        Row(
          children: [
            // 90% - Font Dropdown
            Expanded(
              flex: 9,
              child: AppDropDownWidget<String>(
                height: 75,
                items: fontItems,
                selectedValue:
                    context.read<AppearanceCubit>().state.fontFamily ?? 'System',
                onChanged: (item) =>
                    context.read<AppearanceCubit>().setFontFamily(item?.label ?? ''),
                hint: 'Select font family...',
                leadingIcon: Icon(
                  Icons.font_download,
                  size: 20,
                  color: theme.iconColorScheme.secondary,
                ),
                config: AppDropdownWidgetConfig.defaultConfig(context),
              ),
            ),
            SizedBox(width: theme.spacing.m),
            // 10% - Reset Button
            _ResetFontButton(
              onReset: context.read<AppearanceCubit>().resetFontFamily,
            ),
          ],
        ),
      ],
    );
  }
}

/// Reset font family button
class _ResetFontButton extends StatelessWidget {
  const _ResetFontButton({
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
