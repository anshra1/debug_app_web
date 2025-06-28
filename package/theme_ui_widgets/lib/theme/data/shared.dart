import 'package:flutter/material.dart';
import 'package:theme_ui_widgets/theme/definition/border_radius/border_radius.dart';
import 'package:theme_ui_widgets/theme/definition/shadow/shadow.dart';
import 'package:theme_ui_widgets/theme/definition/spacing/spacing.dart';


class AppSpacingConstant {
  static const double spacing100 = 4;
  static const double spacing200 = 6;
  static const double spacing300 = 8;
  static const double spacing400 = 12;
  static const double spacing500 = 16;
  static const double spacing600 = 20;
}

class AppBorderRadiusConstant {
  static const double radius100 = 4;
  static const double radius200 = 6;
  static const double radius300 = 8;
  static const double radius400 = 12;
  static const double radius500 = 16;
  static const double radius600 = 20;
}

class AppSharedTokens {
  const AppSharedTokens();

  static AppBorderRadius buildBorderRadius() {
    return const AppBorderRadius(
      xs: AppBorderRadiusConstant.radius100,
      s: AppBorderRadiusConstant.radius200,
      m: AppBorderRadiusConstant.radius300,
      l: AppBorderRadiusConstant.radius400,
      xl: AppBorderRadiusConstant.radius500,
      xxl: AppBorderRadiusConstant.radius600,
    );
  }

  static AppSpacing buildSpacing() {
    return const AppSpacing(
      xs: AppSpacingConstant.spacing100,
      s: AppSpacingConstant.spacing200,
      m: AppSpacingConstant.spacing300,
      l: AppSpacingConstant.spacing400,
      xl: AppSpacingConstant.spacing500,
      xxl: AppSpacingConstant.spacing600,
    );
  }

  static AppShadow buildShadow(Brightness brightness) {
    return switch (brightness) {
      Brightness.light => const AppShadow(
        small: [
          AppBoxShadow(
            offsetX: 0,
            offsetY: 2,
            blurRadius: 16,
            spreadRadius: 0,
            color: '#1F000000',
          ),
        ],
        medium: [
          AppBoxShadow(
            offsetX: 0,
            offsetY: 4,
            blurRadius: 32,
            spreadRadius: 0,
            color: '#1F000000',
          ),
        ],
      ),
      Brightness.dark => const AppShadow(
        small: [
          AppBoxShadow(
            offsetX: 0,
            offsetY: 2,
            blurRadius: 16,
            spreadRadius: 0,
            color: '#7A000000',
          ),
        ],
        medium: [
          AppBoxShadow(
            offsetX: 0,
            offsetY: 4,
            blurRadius: 32,
            spreadRadius: 0,
            color: '#7A000000',
          ),
        ],
      ),
    };
  }
}
