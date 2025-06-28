import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:debug_app_web/core/manager/file_manager/interfaces/decoder.dart';
import 'package:debug_app_web/core/utils/utils/hex_color_converter.dart';
import 'package:debug_app_web/features/apperence/models/app_theme_color_set.dart';
import 'package:debug_app_web/features/apperence/models/app_theme_set.dart';
import 'package:path/path.dart' as path;
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

class ThemeSetDecoder implements Decoder<AppThemeSet> {
  @override
  bool canDecode(File file) {
    // Check if it's a directory and follows .theme_design pattern
    if (!Directory(file.path).existsSync() ||
        !FileSystemEntity.isDirectorySync(file.path)) {
      return false;
    }

    final dirName = path.basename(file.path);
    if (!dirName.endsWith('.theme_design')) {
      return false;
    }

    // Check if required files exist
    final directory = Directory(file.path);
    final files = directory.listSync();

    var hasLightTheme = false;
    var hasDarkTheme = false;

    for (final entity in files) {
      if (entity is File) {
        if (path.basename(entity.path) == 'light.json') {
          hasLightTheme = true;
        } else if (path.basename(entity.path) == 'dark.json') {
          hasDarkTheme = true;
        }
      }
    }

    return hasLightTheme && hasDarkTheme;
  }

//   themes/
// ├── ocean_blue.theme_design/
// │   ├── light.json
// │   └── dark.json
// ├── forest_green.theme_design/
// │   ├── light.json
// │   └── dark.json
// ├── sunset_orange.theme_design/
// │   ├── light.json
// │   └── dark.json
// └── ...

  @override
  Future<AppThemeSet> decode(File file) async {
    if (!canDecode(file)) {
      throw Exception('Invalid theme directory structure');
    }

    final directory = Directory(file.path);
    final themeName = path.basename(directory.path).replaceAll('.theme_design', '');

    try {
      // Read and parse light theme
      final lightThemeFile = File('${directory.path}/light.json');
      final lightThemeJson = jsonDecode(await lightThemeFile.readAsString());
      final processedLightJson = HexColorConverter.convertHexColorsInJson(
        lightThemeJson as Map<String, dynamic>,
      );
      final lightThemeColors = AppThemeColorSet.fromJson(processedLightJson);

      // Read and parse dark theme
      final darkThemeFile = File('${directory.path}/dark.json');
      final darkThemeJson = jsonDecode(await darkThemeFile.readAsString());
      final processedDarkJson =
          HexColorConverter.convertHexColorsInJson(darkThemeJson as Map<String, dynamic>);
      final darkThemeColors = AppThemeColorSet.fromJson(processedDarkJson);

      // Validate both themes
      _validateThemeColors(lightThemeColors);
      _validateThemeColors(darkThemeColors);

      return AppThemeSet(
        isInbuilt: false,
        themeName: themeName,
        lightThemeColors: lightThemeColors,
        darkThemeColors: darkThemeColors,
      );
    } catch (e) {
      throw Exception('Failed to decode theme "$themeName": $e');
    }
  }

  void _validateThemeColors(AppThemeColorSet themeColors) {
    // Validate that all required color schemes are present
    _validateTextColorScheme(themeColors.textColorScheme);
    _validateIconColorScheme(themeColors.iconColorScheme);
    _validateBorderColorScheme(themeColors.borderColorScheme);
    _validateBadgeColorScheme(themeColors.badgeColorScheme);
    _validateBackgroundColorScheme(themeColors.backgroundColorScheme);
    _validateFillColorScheme(themeColors.fillColorScheme);
    _validateSurfaceColorScheme(themeColors.surfaceColorScheme);
    _validateBrandColorScheme(themeColors.brandColorScheme);
    _validateSurfaceContainerColorScheme(themeColors.surfaceContainerColorScheme);
    _validateOtherColorsColorScheme(themeColors.otherColorsColorScheme);
  }

  void _validateTextColorScheme(AppTextColorScheme textColorScheme) {
    _validateColor(textColorScheme.primary, 'TextColorScheme.primary');
    _validateColor(textColorScheme.secondary, 'TextColorScheme.secondary');
    _validateColor(textColorScheme.tertiary, 'TextColorScheme.tertiary');
    _validateColor(textColorScheme.quaternary, 'TextColorScheme.quaternary');
    _validateColor(textColorScheme.onFill, 'TextColorScheme.onFill');
    _validateColor(textColorScheme.action, 'TextColorScheme.action');
    _validateColor(textColorScheme.actionHover, 'TextColorScheme.actionHover');
    _validateColor(textColorScheme.info, 'TextColorScheme.info');
    _validateColor(textColorScheme.infoHover, 'TextColorScheme.infoHover');
    _validateColor(textColorScheme.success, 'TextColorScheme.success');
    _validateColor(textColorScheme.successHover, 'TextColorScheme.successHover');
    _validateColor(textColorScheme.warning, 'TextColorScheme.warning');
    _validateColor(textColorScheme.warningHover, 'TextColorScheme.warningHover');
    _validateColor(textColorScheme.error, 'TextColorScheme.error');
    _validateColor(textColorScheme.errorHover, 'TextColorScheme.errorHover');
    _validateColor(textColorScheme.featured, 'TextColorScheme.featured');
    _validateColor(textColorScheme.featuredHover, 'TextColorScheme.featuredHover');
  }

  void _validateIconColorScheme(AppIconColorScheme iconColorScheme) {
    _validateColor(iconColorScheme.primary, 'IconColorScheme.primary');
    _validateColor(iconColorScheme.secondary, 'IconColorScheme.secondary');
    _validateColor(iconColorScheme.tertiary, 'IconColorScheme.tertiary');
    _validateColor(iconColorScheme.quaternary, 'IconColorScheme.quaternary');
    _validateColor(iconColorScheme.onFill, 'IconColorScheme.onFill');
    _validateColor(iconColorScheme.featuredThick, 'IconColorScheme.featuredThick');
    _validateColor(
      iconColorScheme.featuredThickHover,
      'IconColorScheme.featuredThickHover',
    );
    _validateColor(iconColorScheme.infoThick, 'IconColorScheme.infoThick');
    _validateColor(iconColorScheme.infoThickHover, 'IconColorScheme.infoThickHover');
    _validateColor(iconColorScheme.successThick, 'IconColorScheme.successThick');
    _validateColor(
      iconColorScheme.successThickHover,
      'IconColorScheme.successThickHover',
    );
    _validateColor(iconColorScheme.warningThick, 'IconColorScheme.warningThick');
    _validateColor(
      iconColorScheme.warningThickHover,
      'IconColorScheme.warningThickHover',
    );
    _validateColor(iconColorScheme.errorThick, 'IconColorScheme.errorThick');
    _validateColor(iconColorScheme.errorThickHover, 'IconColorScheme.errorThickHover');
  }

  void _validateBorderColorScheme(AppBorderColorScheme borderColorScheme) {
    _validateColor(borderColorScheme.primary, 'BorderColorScheme.primary');
    _validateColor(borderColorScheme.primaryHover, 'BorderColorScheme.primaryHover');
    _validateColor(borderColorScheme.secondary, 'BorderColorScheme.secondary');
    _validateColor(borderColorScheme.secondaryHover, 'BorderColorScheme.secondaryHover');
    _validateColor(borderColorScheme.tertiary, 'BorderColorScheme.tertiary');
    _validateColor(borderColorScheme.tertiaryHover, 'BorderColorScheme.tertiaryHover');
    _validateColor(borderColorScheme.themeThick, 'BorderColorScheme.themeThick');
    _validateColor(
      borderColorScheme.themeThickHover,
      'BorderColorScheme.themeThickHover',
    );
    _validateColor(borderColorScheme.infoThick, 'BorderColorScheme.infoThick');
    _validateColor(borderColorScheme.infoThickHover, 'BorderColorScheme.infoThickHover');
    _validateColor(borderColorScheme.successThick, 'BorderColorScheme.successThick');
    _validateColor(
      borderColorScheme.successThickHover,
      'BorderColorScheme.successThickHover',
    );
    _validateColor(borderColorScheme.warningThick, 'BorderColorScheme.warningThick');
    _validateColor(
      borderColorScheme.warningThickHover,
      'BorderColorScheme.warningThickHover',
    );
    _validateColor(borderColorScheme.errorThick, 'BorderColorScheme.errorThick');
    _validateColor(
      borderColorScheme.errorThickHover,
      'BorderColorScheme.errorThickHover',
    );
    _validateColor(borderColorScheme.featuredThick, 'BorderColorScheme.featuredThick');
    _validateColor(
      borderColorScheme.featuredThickHover,
      'BorderColorScheme.featuredThickHover',
    );
  }

  void _validateBadgeColorScheme(AppBadgeColorScheme badgeColorScheme) {
    if (badgeColorScheme.badgeColors.isEmpty) {
      throw Exception('BadgeColorScheme must contain at least one badge color');
    }

    for (var i = 0; i < badgeColorScheme.badgeColors.length; i++) {
      final badge = badgeColorScheme.badgeColors[i];
      _validateColor(badge.light1, 'BadgeColorScheme.badgeColors[$i].light1');
      _validateColor(badge.light2, 'BadgeColorScheme.badgeColors[$i].light2');
      _validateColor(badge.light3, 'BadgeColorScheme.badgeColors[$i].light3');
      _validateColor(badge.thick1, 'BadgeColorScheme.badgeColors[$i].thick1');
      _validateColor(badge.thick2, 'BadgeColorScheme.badgeColors[$i].thick2');
      _validateColor(badge.thick3, 'BadgeColorScheme.badgeColors[$i].thick3');
    }
  }

  void _validateBackgroundColorScheme(AppBackgroundColorScheme backgroundColorScheme) {
    _validateColor(backgroundColorScheme.primary, 'BackgroundColorScheme.primary');
  }

  void _validateFillColorScheme(AppFillColorScheme fillColorScheme) {
    _validateColor(fillColorScheme.primary, 'FillColorScheme.primary');
    _validateColor(fillColorScheme.primaryHover, 'FillColorScheme.primaryHover');
    _validateColor(fillColorScheme.secondary, 'FillColorScheme.secondary');
    _validateColor(fillColorScheme.secondaryHover, 'FillColorScheme.secondaryHover');
    _validateColor(fillColorScheme.tertiary, 'FillColorScheme.tertiary');
    _validateColor(fillColorScheme.tertiaryHover, 'FillColorScheme.tertiaryHover');
    _validateColor(fillColorScheme.quaternary, 'FillColorScheme.quaternary');
    _validateColor(fillColorScheme.quaternaryHover, 'FillColorScheme.quaternaryHover');
    _validateColor(fillColorScheme.content, 'FillColorScheme.content');
    _validateColor(fillColorScheme.contentHover, 'FillColorScheme.contentHover');
    _validateColor(fillColorScheme.contentVisible, 'FillColorScheme.contentVisible');
    _validateColor(
      fillColorScheme.contentVisibleHover,
      'FillColorScheme.contentVisibleHover',
    );
    _validateColor(fillColorScheme.themeThick, 'FillColorScheme.themeThick');
    _validateColor(fillColorScheme.themeThickHover, 'FillColorScheme.themeThickHover');
    _validateColor(fillColorScheme.themeSelect, 'FillColorScheme.themeSelect');
    _validateColor(fillColorScheme.textSelect, 'FillColorScheme.textSelect');
    _validateColor(fillColorScheme.infoLight, 'FillColorScheme.infoLight');
    _validateColor(fillColorScheme.infoLightHover, 'FillColorScheme.infoLightHover');
    _validateColor(fillColorScheme.infoThick, 'FillColorScheme.infoThick');
    _validateColor(fillColorScheme.infoThickHover, 'FillColorScheme.infoThickHover');
    _validateColor(fillColorScheme.successLight, 'FillColorScheme.successLight');
    _validateColor(
      fillColorScheme.successLightHover,
      'FillColorScheme.successLightHover',
    );
    _validateColor(fillColorScheme.warningLight, 'FillColorScheme.warningLight');
    _validateColor(
      fillColorScheme.warningLightHover,
      'FillColorScheme.warningLightHover',
    );
    _validateColor(fillColorScheme.errorLight, 'FillColorScheme.errorLight');
    _validateColor(fillColorScheme.errorLightHover, 'FillColorScheme.errorLightHover');
    _validateColor(fillColorScheme.errorThick, 'FillColorScheme.errorThick');
    _validateColor(fillColorScheme.errorThickHover, 'FillColorScheme.errorThickHover');
    _validateColor(fillColorScheme.errorSelect, 'FillColorScheme.errorSelect');
    _validateColor(fillColorScheme.featuredLight, 'FillColorScheme.featuredLight');
    _validateColor(
      fillColorScheme.featuredLightHover,
      'FillColorScheme.featuredLightHover',
    );
    _validateColor(fillColorScheme.featuredThick, 'FillColorScheme.featuredThick');
    _validateColor(
      fillColorScheme.featuredThickHover,
      'FillColorScheme.featuredThickHover',
    );
  }

  void _validateSurfaceColorScheme(AppSurfaceColorScheme surfaceColorScheme) {
    _validateColor(surfaceColorScheme.primary, 'SurfaceColorScheme.primary');
    _validateColor(surfaceColorScheme.primaryHover, 'SurfaceColorScheme.primaryHover');
    _validateColor(surfaceColorScheme.layer01, 'SurfaceColorScheme.layer01');
    _validateColor(surfaceColorScheme.layer01Hover, 'SurfaceColorScheme.layer01Hover');
    _validateColor(surfaceColorScheme.layer02, 'SurfaceColorScheme.layer02');
    _validateColor(surfaceColorScheme.layer02Hover, 'SurfaceColorScheme.layer02Hover');
    _validateColor(surfaceColorScheme.layer03, 'SurfaceColorScheme.layer03');
    _validateColor(surfaceColorScheme.layer03Hover, 'SurfaceColorScheme.layer03Hover');
    _validateColor(surfaceColorScheme.layer04, 'SurfaceColorScheme.layer04');
    _validateColor(surfaceColorScheme.layer04Hover, 'SurfaceColorScheme.layer04Hover');
    _validateColor(surfaceColorScheme.inverse, 'SurfaceColorScheme.inverse');
    _validateColor(surfaceColorScheme.secondary, 'SurfaceColorScheme.secondary');
    _validateColor(surfaceColorScheme.overlay, 'SurfaceColorScheme.overlay');
  }

  void _validateBrandColorScheme(AppBrandColorScheme brandColorScheme) {
    _validateColor(brandColorScheme.skyline, 'BrandColorScheme.skyline');
    _validateColor(brandColorScheme.aqua, 'BrandColorScheme.aqua');
    _validateColor(brandColorScheme.violet, 'BrandColorScheme.violet');
    _validateColor(brandColorScheme.amethyst, 'BrandColorScheme.amethyst');
    _validateColor(brandColorScheme.berry, 'BrandColorScheme.berry');
    _validateColor(brandColorScheme.coral, 'BrandColorScheme.coral');
    _validateColor(brandColorScheme.golden, 'BrandColorScheme.golden');
    _validateColor(brandColorScheme.amber, 'BrandColorScheme.amber');
    _validateColor(brandColorScheme.lemon, 'BrandColorScheme.lemon');
  }

  void _validateSurfaceContainerColorScheme(
    AppSurfaceContainerColorScheme surfaceContainerColorScheme,
  ) {
    _validateColor(
      surfaceContainerColorScheme.layer01,
      'SurfaceContainerColorScheme.layer01',
    );
    _validateColor(
      surfaceContainerColorScheme.layer02,
      'SurfaceContainerColorScheme.layer02',
    );
    _validateColor(
      surfaceContainerColorScheme.layer03,
      'SurfaceContainerColorScheme.layer03',
    );
  }

  void _validateOtherColorsColorScheme(AppOtherColorsColorScheme otherColorsColorScheme) {
    _validateColor(
      otherColorsColorScheme.textHighlight,
      'OtherColorsColorScheme.textHighlight',
    );
  }

  void _validateColor(Color color, String colorName) {
    try {
      HexColorConverter.validateColor(color, colorName);
    } catch (e) {
      throw Exception('Theme validation failed for $colorName: $e');
    }
  }
}
