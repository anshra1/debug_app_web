import 'package:debug_app_web/features/setting/workspace/models/app_theme_color_set.dart';

abstract class AppThemeColorSetBuilder {
  const AppThemeColorSetBuilder();

  AppThemeColorSet light();

  AppThemeColorSet dark();
}
