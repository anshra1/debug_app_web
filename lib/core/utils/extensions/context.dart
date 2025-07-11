import 'package:flutter/material.dart';
import 'package:theme_ui_widgets/theme/app_theme.dart';
import 'package:theme_ui_widgets/theme/definition/theme_data.dart';

extension ComponentThemeExtension on BuildContext {
  ThemeData get theme => Theme.of(this);

}

extension AppThemeExtension on BuildContext {
  AppThemeData get appTheme => AppTheme.of(this);
}