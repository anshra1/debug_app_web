import 'package:debug_app_web/features/setting/workspace/abstract/app_theme_builder.dart';
import 'package:debug_app_web/features/setting/workspace/models/import_theme_color_set.dart';
import 'package:flutter/material.dart';

import 'package:theme_ui_widgets/theme_ui_widgets.dart';

class AppCustomJsonTheme implements AppThemeColorSetBuilder {
  @override
  ImportThemeColorSet light() {
    const textColorScheme = AppTextColorScheme(
      primary: Color(0xff555555),
      secondary: Color(0xff777777),
      tertiary: Color(0xff828282),
      quaternary: Color(0xffe0e0e0),
      onFill: Color(0xfff8f8f2),
      action: Color(0xff7e8ec2),
      actionHover: Color(0xffe9f284),
      info: Color(0xffe9f284),
      infoHover: Color(0xffe9f284),
      success: Color(0xff69ff94),
      successHover: Color(0xff69ff94),
      warning: Color(0xffe9f284),
      warningHover: Color(0xffe9f284),
      error: Color(0xffff6e6e),
      errorHover: Color(0xffff6e6e),
      featured: Color(0xff7e8ec2),
      featuredHover: Color(0xff7e8ec2),
    );

    const iconColorScheme = AppIconColorScheme(
      primary: Color(0xff555555),
      secondary: Color(0xff777777),
      tertiary: Color(0xff828282),
      quaternary: Color(0xffe0e0e0),
      infoThick: Color(0xffe9f284),
      infoThickHover: Color(0xffe9f284),
      successThick: Color(0xff69ff94),
      successThickHover: Color(0xff69ff94),
      warningThick: Color(0xffe9f284),
      warningThickHover: Color(0xffe9f284),
      errorThick: Color(0xffff6e6e),
      errorThickHover: Color(0xffff6e6e),
      featuredThick: Color(0xff7e8ec2),
      featuredThickHover: Color(0xff7e8ec2),
      onFill: Color(0xfff8f8f2),
    );

    const borderColorScheme = AppBorderColorScheme(
      primary: Color(0xffededee),
      primaryHover: Color(0xffe0e0e0),
      secondary: Color(0xffe2e4eb),
      secondaryHover: Color(0xffedeef2),
      tertiary: Color(0xffe2e4eb),
      tertiaryHover: Color(0xffedeef2),
      themeThick: Color(0xff7e8ec2),
      themeThickHover: Color(0xffe9f284),
      infoThick: Color(0xffe9f284),
      infoThickHover: Color(0xffe9f284),
      successThick: Color(0xff69ff94),
      successThickHover: Color(0xff69ff94),
      warningThick: Color(0xffe9f284),
      warningThickHover: Color(0xffe9f284),
      errorThick: Color(0xffff6e6e),
      errorThickHover: Color(0xffff6e6e),
      featuredThick: Color(0xff7e8ec2),
      featuredThickHover: Color(0xff7e8ec2),
    );

    const fillColorScheme = AppFillColorScheme(
      primary: Color(0xfff8f8f2),
      primaryHover: Color(0xffe9f284),
      secondary: Color(0xffe0e0e0),
      secondaryHover: Color(0xffe9f284),
      tertiary: Color(0xffe2e4eb),
      tertiaryHover: Color(0xffedeef2),
      quaternary: Color(0xffe0e0e0),
      quaternaryHover: Color(0xffe9f284),
      content: Color(0x00ffffff),
      contentHover: Color(0x05ffffff),
      contentVisible: Color(0xfff8f8f2),
      contentVisibleHover: Color(0x10ffffff),
      themeThick: Color(0xff7e8ec2),
      themeThickHover: Color(0xffe9f284),
      themeSelect: Color(0x1affe9f2),
      textSelect: Color(0x20ffe9f2),
      infoLight: Color(0xffe9f284),
      infoLightHover: Color(0xffe9f284),
      infoThick: Color(0xffe9f284),
      infoThickHover: Color(0xffe9f284),
      successLight: Color(0xff69ff94),
      successLightHover: Color(0xff69ff94),
      warningLight: Color(0xffe9f284),
      warningLightHover: Color(0xffe9f284),
      errorLight: Color(0xffff6e6e),
      errorLightHover: Color(0xffff6e6e),
      errorThick: Color(0xffff6e6e),
      errorThickHover: Color(0xffff6e6e),
      errorSelect: Color(0x10ffff6e),
      featuredLight: Color(0xff7e8ec2),
      featuredLightHover: Color(0xff7e8ec2),
      featuredThick: Color(0xff7e8ec2),
      featuredThickHover: Color(0xff7e8ec2),
    );

    const surfaceColorScheme = AppSurfaceColorScheme(
      primary: Color(0xfff8f8f2),
      primaryHover: Color(0xffe9f284),
      layer01: Color(0xfff8f8f2),
      layer01Hover: Color(0xffe9f284),
      layer02: Color(0xffe0e0e0),
      layer02Hover: Color(0xffe9f284),
      layer03: Color(0xffe0e0e0),
      layer03Hover: Color(0xffe9f284),
      layer04: Color(0xffe0e0e0),
      layer04Hover: Color(0xffe9f284),
      inverse: Color(0xff000000),
      secondary: Color(0xff000000),
      overlay: Color(0x60000000),
    );

    const surfaceContainerColorScheme = AppSurfaceContainerColorScheme(
      layer01: Color(0xfff8f8f2),
      layer02: Color(0xffe0e0e0),
      layer03: Color(0xffe0e0e0),
    );

    const backgroundColorScheme = AppBackgroundColorScheme(
      primary: Color(0xfff7f8fc),
    );

    const brandColorScheme = AppBrandColorScheme(
      skyline: Color(0xffe9f284),
      aqua: Color(0xffe9f284),
      violet: Color(0xff7e8ec2),
      amethyst: Color(0xff7e8ec2),
      berry: Color(0xffe9f284),
      coral: Color(0xffe9f284),
      golden: Color(0xffe9f284),
      amber: Color(0xffe9f284),
      lemon: Color(0xffe9f284),
    );

    const otherColorsColorScheme = AppOtherColorsColorScheme(
      textHighlight: Color(0xffe9f284),
    );

    return const ImportThemeColorSet(
      themeName: 'custom_json_theme',
      textColorScheme: textColorScheme,
      borderColorScheme: borderColorScheme,
      fillColorScheme: fillColorScheme,
      surfaceColorScheme: surfaceColorScheme,
      backgroundColorScheme: backgroundColorScheme,
      iconColorScheme: iconColorScheme,

      surfaceContainerColorScheme: surfaceContainerColorScheme,
      badgeColorScheme: AppBadgeColorScheme(badgeColors: []),
    );
  }

  @override
  ImportThemeColorSet dark() {
    const textColorScheme = AppTextColorScheme(
      primary: Color(0xfff8f8f2),
      secondary: Color(0xfff8f8f2),
      tertiary: Color(0xff8f959e),
      quaternary: Color(0xffffffff),
      onFill: Color(0xff131720),
      action: Color(0xff8be9fd),
      actionHover: Color(0xff8be9fd),
      info: Color(0xff8be9fd),
      infoHover: Color(0xff8be9fd),
      success: Color(0xff50fa7b),
      successHover: Color(0xff50fa7b),
      warning: Color(0xfff1fa8c),
      warningHover: Color(0xfff1fa8c),
      error: Color(0xffff5555),
      errorHover: Color(0xffff5555),
      featured: Color(0xff8be9fd),
      featuredHover: Color(0xff8be9fd),
    );

    const iconColorScheme = AppIconColorScheme(
      primary: Color(0xfff8f8f2),
      secondary: Color(0xfff8f8f2),
      tertiary: Color(0xff8f959e),
      quaternary: Color(0xffffffff),
      infoThick: Color(0xff8be9fd),
      infoThickHover: Color(0xff8be9fd),
      successThick: Color(0xff50fa7b),
      successThickHover: Color(0xff50fa7b),
      warningThick: Color(0xfff1fa8c),
      warningThickHover: Color(0xfff1fa8c),
      errorThick: Color(0xffff5555),
      errorThickHover: Color(0xffff5555),
      featuredThick: Color(0xff8be9fd),
      featuredThickHover: Color(0xff8be9fd),
      onFill: Color(0xff131720),
    );

    const borderColorScheme = AppBorderColorScheme(
      primary: Color(0xff6272a4),
      primaryHover: Color(0xff505469),
      secondary: Color(0xff363d49),
      secondaryHover: Color(0xff363d49),
      tertiary: Color(0xff1a202c),
      tertiaryHover: Color(0xff1a202c),
      themeThick: Color(0xff8be9fd),
      themeThickHover: Color(0xff8be9fd),
      infoThick: Color(0xff8be9fd),
      infoThickHover: Color(0xff8be9fd),
      successThick: Color(0xff50fa7b),
      successThickHover: Color(0xff50fa7b),
      warningThick: Color(0xfff1fa8c),
      warningThickHover: Color(0xfff1fa8c),
      errorThick: Color(0xffff5555),
      errorThickHover: Color(0xffff5555),
      featuredThick: Color(0xff8be9fd),
      featuredThickHover: Color(0xff8be9fd),
    );

    const fillColorScheme = AppFillColorScheme(
      primary: Color(0xff252526),
      primaryHover: Color(0xff8be9fd),
      secondary: Color(0xff363d49),
      secondaryHover: Color(0xff363d49),
      tertiary: Color(0xff505469),
      tertiaryHover: Color(0xff505469),
      quaternary: Color(0xffbbc3cd),
      quaternaryHover: Color(0xffbbc3cd),
      content: Color(0x00000000),
      contentHover: Color(0x05000000),
      contentVisible: Color(0xff282e3a),
      contentVisibleHover: Color(0x10000000),
      themeThick: Color(0xff8be9fd),
      themeThickHover: Color(0xff8be9fd),
      themeSelect: Color(0x1a8be9fd),
      textSelect: Color(0x208be9fd),
      infoLight: Color(0xff8be9fd),
      infoLightHover: Color(0xff8be9fd),
      infoThick: Color(0xff8be9fd),
      infoThickHover: Color(0xff8be9fd),
      successLight: Color(0xff50fa7b),
      successLightHover: Color(0xff50fa7b),
      warningLight: Color(0xfff1fa8c),
      warningLightHover: Color(0xfff1fa8c),
      errorLight: Color(0xffff5555),
      errorLightHover: Color(0xffff5555),
      errorThick: Color(0xffff5555),
      errorThickHover: Color(0xffff5555),
      errorSelect: Color(0x10ffff55),
      featuredLight: Color(0xff8be9fd),
      featuredLightHover: Color(0xff8be9fd),
      featuredThick: Color(0xff8be9fd),
      featuredThickHover: Color(0xff8be9fd),
    );

    const surfaceColorScheme = AppSurfaceColorScheme(
      primary: Color(0xff1e1e1e),
      primaryHover: Color(0xff252526),
      layer01: Color(0xff1e1e1e),
      layer01Hover: Color(0xff252526),
      layer02: Color(0xff252526),
      layer02Hover: Color(0xff363d49),
      layer03: Color(0xff363d49),
      layer03Hover: Color(0xff363d49),
      layer04: Color(0xff2c2c2c),
      layer04Hover: Color(0xff363d49),
      inverse: Color(0xff131720),
      secondary: Color(0xff1a202c),
      overlay: Color(0x60000000),
    );

    const surfaceContainerColorScheme = AppSurfaceContainerColorScheme(
      layer01: Color(0xff1e1e1e),
      layer02: Color(0xff252526),
      layer03: Color(0xff363d49),
    );

    const backgroundColorScheme = AppBackgroundColorScheme(
      primary: Color(0xff1e1e1e),
    );

    const brandColorScheme = AppBrandColorScheme(
      skyline: Color(0xff8be9fd),
      aqua: Color(0xff8be9fd),
      violet: Color(0xff8be9fd),
      amethyst: Color(0xff8be9fd),
      berry: Color(0xff8be9fd),
      coral: Color(0xff8be9fd),
      golden: Color(0xff8be9fd),
      amber: Color(0xff8be9fd),
      lemon: Color(0xff8be9fd),
    );

    

    return const ImportThemeColorSet(
      themeName: 'custom_json_theme',
      textColorScheme: textColorScheme,
      borderColorScheme: borderColorScheme,
      fillColorScheme: fillColorScheme,
      surfaceColorScheme: surfaceColorScheme,
      backgroundColorScheme: backgroundColorScheme,
      iconColorScheme: iconColorScheme,
    
      surfaceContainerColorScheme: surfaceContainerColorScheme,
      badgeColorScheme: AppBadgeColorScheme(badgeColors: []),
    );
  }
}
