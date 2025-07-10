import 'package:debug_app_web/features/setting/workspace/models/import_theme_color_set.dart';

abstract class AppThemeColorSetBuilder {
  const AppThemeColorSetBuilder();

  ImportThemeColorSet light();

  ImportThemeColorSet dark();
}
