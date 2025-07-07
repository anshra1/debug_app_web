import 'package:debug_app_web/core/constants/build.dart';
import 'package:debug_app_web/core/widgets/atoms/display/app_divider.dart';
import 'package:debug_app_web/core/widgets/atoms/display/app_header_widget.dart';
import 'package:debug_app_web/core/widgets/atoms/display/toggle.dart';
import 'package:debug_app_web/core/widgets/atoms/inputs/app_dropdown_widget.dart';
import 'package:debug_app_web/features/setting/workspace/cubit/appearance_cubit.dart';
import 'package:debug_app_web/features/setting/workspace/cubit/apperence_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:theme_ui_widgets/theme/app_theme.dart';

class DateTimeSettingsWidget extends HookWidget {
  const DateTimeSettingsWidget({super.key});
// did you read the past history
  @override
  Widget build(BuildContext context) {
    useDebugRebuildTracker(
      'DateTimeSettingsWidget',
      customLogThreshold: 1,
      customWarningThreshold: 3,
    );

    // 🎯 SOLUTION: Move hooks outside BlocBuilder to main build method
    final rebuild = useState(0);
    final cubit = context.read<AppearanceCubit>();

    // 🎯 SOLUTION: Use BlocBuilder with buildWhen to control rebuilds
    return BlocBuilder<AppearanceCubit, AppearanceState>(
      buildWhen: (previous, current) {
        // Only rebuild when timeFormat or dateFormat changes
        return previous.timeFormat != current.timeFormat ||
            previous.dateFormat != current.dateFormat;
      },
      builder: (context, state) {
        final theme = AppTheme.of(context);

        // Create dropdown items for date formats
        final dateFormatItems = [
          const SimpleDropdownItem<String>('ISO', 'iso'),
          const SimpleDropdownItem<String>('US', 'us'),
          const SimpleDropdownItem<String>('Local', 'local'),
          const SimpleDropdownItem<String>('Friendly', 'friendly'),
        ];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header
            const AppHeaderWidget(title: 'Date & time'),

            SizedBox(height: theme.spacing.l),
            AppDividers.standard(context),

            SizedBox(height: theme.spacing.l),

            // 3. 24-hour Toggle
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '24-hour time',
                  style: theme.textStyle.bodyLarge.prominent(
                    context: context,
                    color: theme.textColorScheme.primary,
                  ),
                ),
                Toggle(
                  value: state.timeFormat == '24h',
                  onChanged: ({bool? value}) {
                    cubit.toggleTimeFormat();
                  },
                  config: ToggleConfig.big(context),
                ),
              ],
            ),

            SizedBox(height: theme.spacing.l),

            // 4. Date Format Dropdown
            Text(
              'Date format',
              style: theme.textStyle.bodyMedium.prominent(
                context: context,
                color: theme.textColorScheme.primary,
              ),
            ),
            SizedBox(height: theme.spacing.s),
            AppDropDownWidget<String>(
              items: dateFormatItems,
              selectedValue: state.dateFormat,
              onChanged: (item) {
                cubit.setDateFormat(item?.label ?? '');
                rebuild.value++;
              },
              hint: 'Select date format...',
              config: AppDropdownWidgetConfig.defaultConfig(context),
            ),
          ],
        );
      },
    );
  }
}
