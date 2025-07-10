import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:theme_ui_widgets/theme/definition/color_scheme/brand/badge_color_scheme.dart';
import 'package:theme_ui_widgets/theme/definition/color_scheme/color_scheme.dart';

part 'import_theme_color_set.freezed.dart';
part 'import_theme_color_set.g.dart';

@freezed
class ImportThemeColorSet with _$ImportThemeColorSet {
  const factory ImportThemeColorSet({
    required String themeName,
    required AppTextColorScheme textColorScheme,
    required AppIconColorScheme iconColorScheme,
    required AppBorderColorScheme borderColorScheme,
    required AppBadgeColorScheme badgeColorScheme,
    required AppBackgroundColorScheme backgroundColorScheme,
    required AppFillColorScheme fillColorScheme,
    required AppSurfaceColorScheme surfaceColorScheme,
    required AppSurfaceContainerColorScheme surfaceContainerColorScheme,
  }) = _ImportThemeColorSet;

  factory ImportThemeColorSet.fromJson(Map<String, dynamic> json) =>
      _$ImportThemeColorSetFromJson(json);
}
