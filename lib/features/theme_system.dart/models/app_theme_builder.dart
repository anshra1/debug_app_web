import 'package:debug_app_web/features/theme_system.dart/models/app_theme_color_set.dart';

abstract class AppThemeColorSetBuilder {
  const AppThemeColorSetBuilder();

  AppThemeColorSet light({
    String? fontFamily,
  });

  AppThemeColorSet dark({
    String? fontFamily,
  });
}
