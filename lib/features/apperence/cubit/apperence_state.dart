import 'package:debug_app_web/features/apperence/models/app_default_theme.dart';
import 'package:debug_app_web/features/apperence/models/app_theme_set.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'apperence_state.freezed.dart';

@freezed
class AppearanceState with _$AppearanceState {
  const factory AppearanceState({
    required AppThemeSet appThemeSet,
    required ThemeMode themeMode,
    required String fontFamily,
    required LayoutDirection layoutDirection,
    required TextDirection textDirection,
    required bool enableRtlToolbarItems,
    required Locale locale,
    required bool isMenuCollapsed,
    required double menuOffset,
    required String dateFormat,
    required String timeFormat,
    required String timezoneId,
    required Color? documentCursorColor,
    required Color? documentSelectionColor,
    required double textScaleFactor,
    required bool isLoading,
    required List<AppThemeSet> availableThemes,
    String? errorMessage,
  }) = _AppearanceState;

  factory AppearanceState.initial() => AppearanceState(
        appThemeSet: AppThemeSet(
          isInbuilt: true,
          themeName: 'default',
          lightThemeColors: AppDefaultTheme().light(),
          darkThemeColors: AppDefaultTheme().dark(),
        ),
        themeMode: ThemeMode.light,
        fontFamily: 'Roboto',
        layoutDirection: LayoutDirection.ltr,
        textDirection: TextDirection.ltr,
        enableRtlToolbarItems: false,
        locale: const Locale('en', 'US'),
        isMenuCollapsed: false,
        menuOffset: 0,
        dateFormat: 'MM/dd/yyyy',
        timeFormat: '12h',
        timezoneId: 'UTC',
        documentCursorColor: null,
        documentSelectionColor: null,
        textScaleFactor: 1,
        isLoading: false,
        availableThemes: [],
      );
}

enum LayoutDirection { ltr, rtl }

enum TextDirection { ltr, rtl, auto }
