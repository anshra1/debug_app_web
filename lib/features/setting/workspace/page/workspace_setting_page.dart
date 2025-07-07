import 'package:debug_app_web/core/widgets/atoms/display/app_divider.dart';
import 'package:debug_app_web/features/setting/workspace/cubit/appearance_cubit.dart';
import 'package:debug_app_web/features/setting/workspace/widget/date_widget.dart';
import 'package:debug_app_web/features/setting/workspace/widget/font_selection_widget.dart';
import 'package:debug_app_web/features/setting/workspace/widget/theme_mode_selction_widget.dart';
import 'package:debug_app_web/features/setting/workspace/widget/theme_selection_widget.dart';
import 'package:debug_app_web/features/setting/workspace/widget/workspace_header_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

class WorkspaceSettingPage extends HookWidget {
  const WorkspaceSettingPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeMode = useState(context.read<AppearanceCubit>().state.themeMode);
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 24,
          children: [
            const WorkspaceHeader(),
            AppDividers.standard(context),
            ThemeModeSelectionWidget(
              onThemeModeChanged: (ThemeMode mode) {
                themeMode.value = mode;
                context.read<AppearanceCubit>().setThemeMode(mode);
              },
              selectedThemeMode: themeMode.value,
            ),
            AppDividers.standard(context),
            const FontSelectionWidget(),
            AppDividers.standard(context),
            const ThemeSelectionWidget(),
            AppDividers.standard(context),
            const DateTimeSettingsWidget(),
          ],
        ),
      ),
    );
  }
}
