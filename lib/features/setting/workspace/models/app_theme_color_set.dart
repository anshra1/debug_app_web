import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:theme_ui_widgets/theme/definition/color_scheme/background_color_scheme.dart';
import 'package:theme_ui_widgets/theme/definition/color_scheme/badge_color_scheme.dart';
import 'package:theme_ui_widgets/theme/definition/color_scheme/border_color_scheme.dart';
import 'package:theme_ui_widgets/theme/definition/color_scheme/brand_color_scheme.dart';
import 'package:theme_ui_widgets/theme/definition/color_scheme/fill_color_scheme.dart';
import 'package:theme_ui_widgets/theme/definition/color_scheme/icon_color_scheme.dart';
import 'package:theme_ui_widgets/theme/definition/color_scheme/other_color_scheme.dart';
import 'package:theme_ui_widgets/theme/definition/color_scheme/surface_color_scheme.dart';
import 'package:theme_ui_widgets/theme/definition/color_scheme/surface_container_color_scheme.dart';
import 'package:theme_ui_widgets/theme/definition/color_scheme/text_color_scheme.dart';

part 'app_theme_color_set.freezed.dart';
part 'app_theme_color_set.g.dart';

@freezed
class AppThemeColorSet with _$AppThemeColorSet {
  const factory AppThemeColorSet({
    required String themeName,
    required AppTextColorScheme textColorScheme,
    required AppIconColorScheme iconColorScheme,
    required AppBorderColorScheme borderColorScheme,
    required AppBadgeColorScheme badgeColorScheme,
    required AppBackgroundColorScheme backgroundColorScheme,
    required AppFillColorScheme fillColorScheme,
    required AppSurfaceColorScheme surfaceColorScheme,
    required AppBrandColorScheme brandColorScheme,
    required AppSurfaceContainerColorScheme surfaceContainerColorScheme,
    required AppOtherColorsColorScheme otherColorsColorScheme,
  }) = _AppThemeColorSet;

  factory AppThemeColorSet.fromJson(Map<String, dynamic> json) =>
      _$AppThemeColorSetFromJson(json);
}

