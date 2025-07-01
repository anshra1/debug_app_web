import 'package:debug_app_web/features/setting/workspace/theme/app_default_theme.dart';
import 'package:debug_app_web/features/setting/workspace/models/app_theme_set.dart';

const String defaultThemeName = 'default Theme';

/// Returns a list of built-in themes that come with the application
List<AppThemeSet> inbuiltThemes() {
  return [
    AppThemeSet(
      isInbuilt: true,
      themeName: defaultThemeName,
      lightThemeColors: AppDefaultTheme().light(),
      darkThemeColors: AppDefaultTheme().dark(),
    ),
  ];
}
