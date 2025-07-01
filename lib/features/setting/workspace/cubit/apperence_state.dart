import 'package:debug_app_web/features/setting/workspace/models/app_theme_set.dart';
import 'package:debug_app_web/features/setting/workspace/theme/json_theme.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:google_fonts/google_fonts.dart';

part 'apperence_state.freezed.dart';

@freezed
class AppearanceState with _$AppearanceState {
  const factory AppearanceState({
    required AppThemeSet appThemeSet,
    required ThemeMode themeMode,
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
    String? fontFamily,
    String? errorMessage,
  }) = _AppearanceState;

  factory AppearanceState.initial() => AppearanceState(
        appThemeSet: AppThemeSet(
          isInbuilt: true,
          themeName: 'default',
          fontFamily: GoogleFonts.aDLaMDisplay().fontFamily,
          lightThemeColors: AppCustomJsonTheme().light(),
          darkThemeColors: AppCustomJsonTheme().dark(),
        ),
        themeMode: ThemeMode.light,
        fontFamily: GoogleFonts.aDLaMDisplay().fontFamily,
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
