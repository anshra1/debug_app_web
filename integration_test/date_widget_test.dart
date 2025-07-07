// ignore_for_file: avoid_print

import 'package:debug_app_web/core/widgets/atoms/display/app_header_widget.dart';
import 'package:debug_app_web/core/widgets/atoms/display/toggle.dart';
import 'package:debug_app_web/core/widgets/atoms/inputs/app_dropdown_widget.dart';
import 'package:debug_app_web/features/setting/workspace/cubit/appearance_cubit.dart';
import 'package:debug_app_web/features/setting/workspace/models/app_theme_set.dart';
import 'package:debug_app_web/features/setting/workspace/theme/app_default_theme.dart';
import 'package:debug_app_web/features/setting/workspace/widget/date_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theme_ui_widgets/theme/app_theme.dart';
import 'package:theme_ui_widgets/theme/definition/theme_data.dart';

void main() {
  group('DateTimeSettingsWidget Integration Tests', () {
    late AppThemeData themeData;

    setUp(() {
      final themeSet = AppThemeSet(
        isInbuilt: true,
        themeName: 'Test Theme',
        lightThemeColors: AppDefaultTheme().light(),
        darkThemeColors: AppDefaultTheme().dark(),
      );
      themeData = themeSet.getLightTheme();
    });

    Widget buildTestWidget() {
      return MaterialApp(
        home: Material(
          child: AppTheme(
            data: themeData,
            child: BlocProvider(
              create: (context) => AppearanceCubit(),
              child: const DateTimeSettingsWidget(),
            ),
          ),
        ),
      );
    }

    group('Rendering Tests', () {
      testWidgets('should render all initial components', (tester) async {
        await tester.pumpWidget(buildTestWidget());
        await tester.pumpAndSettle();

        // Verify header
        expect(find.byType(AppHeaderWidget), findsOneWidget);
        expect(find.text('Date & time'), findsOneWidget);

        // Verify time format toggle
        expect(find.text('24-hour time'), findsOneWidget);
        expect(find.byType(Toggle), findsOneWidget);

        // Verify date format dropdown
        expect(find.text('Date format'), findsOneWidget);
        expect(find.byType(AppDropDownWidget<String>), findsOneWidget);
      });

      testWidgets('should show correct initial toggle state', (tester) async {
        await tester.pumpWidget(buildTestWidget());
        await tester.pumpAndSettle();

        final toggle = tester.widget<Toggle>(find.byType(Toggle));
        expect(toggle.value, false); // Default state should be 12h
      });

      testWidgets('should show correct initial date format', (tester) async {
        await tester.pumpWidget(buildTestWidget());
        await tester.pumpAndSettle();

        expect(find.text('Select date format...'), findsOneWidget);
      });
    });

    group('Interaction Tests', () {
      testWidgets('should toggle time format', (tester) async {
        await tester.pumpWidget(buildTestWidget());
        await tester.pumpAndSettle();

        // Initial state
        var toggle = tester.widget<Toggle>(find.byType(Toggle));
        expect(toggle.value, false);

        // Toggle to 24h
        await tester.tap(find.byType(Toggle));
        await tester.pumpAndSettle();

        toggle = tester.widget<Toggle>(find.byType(Toggle));
        expect(toggle.value, true);

        // Toggle back to 12h
        await tester.tap(find.byType(Toggle));
        await tester.pumpAndSettle();

        toggle = tester.widget<Toggle>(find.byType(Toggle));
        expect(toggle.value, false);
      });

      testWidgets('should change date format', (tester) async {
        await tester.pumpWidget(buildTestWidget());
        await tester.pumpAndSettle();

        // Open dropdown
        await tester.tap(find.byType(AppDropDownWidget<String>));
        await tester.pumpAndSettle();

        // Select ISO format
        await tester.tap(find.text('ISO').last);
        await tester.pumpAndSettle();
      });
    });

    group('Rebuild Tests', () {
      testWidgets('should track rebuilds with print statements', (tester) async {
        var rebuildCount = 0;

        Widget buildTrackerWidget() {
          return MaterialApp(
            home: Material(
              child: AppTheme(
                data: themeData,
                child: BlocProvider(
                  create: (context) => AppearanceCubit(),
                  child: Builder(
                    builder: (context) {
                      rebuildCount++;
                      print('🔄 Widget rebuilt: $rebuildCount times');
                      return const DateTimeSettingsWidget();
                    },
                  ),
                ),
              ),
            ),
          );
        }

        await tester.pumpWidget(buildTrackerWidget());
        await tester.pumpAndSettle();
        print('\n--- Initial build completed ---\n');

        // Reset rebuild count after initial setup
        rebuildCount = 0;

        // Get the cubit
        final cubit = BlocProvider.of<AppearanceCubit>(
          tester.element(find.byType(DateTimeSettingsWidget)),
        );

        print('\n--- Testing time format toggle ---');
        // Toggle time format
        await tester.tap(find.byType(Toggle));
        await tester.pumpAndSettle();
        print('Time format state: ${cubit.state.timeFormat}');
        print('Rebuilds after toggle: $rebuildCount\n');

        // Reset rebuild count
        rebuildCount = 0;

        print('\n--- Testing date format change ---');
        // Open dropdown and select date format
        await tester.tap(find.byType(AppDropDownWidget<String>));
        await tester.pumpAndSettle();
        await tester.tap(find.text('ISO').last);
        await tester.pumpAndSettle();
        print('Date format state: ${cubit.state.dateFormat}');
        print('Rebuilds after date format change: $rebuildCount\n');

        // Reset rebuild count
        rebuildCount = 0;

        print('\n--- Testing unrelated state change ---');
        // Trigger unrelated state change
        cubit.emit(cubit.state.copyWith(fontFamily: 'Arial'));
        await tester.pumpAndSettle();
        print('Font family state: ${cubit.state.fontFamily}');
        print('Rebuilds after unrelated change: $rebuildCount\n');

        // Final verification
        print('\n--- Test Summary ---');
        print('Widget behavior verified through console output');
        print('Check rebuild counts in test output above\n');
      });
    });

    group('State Management Tests', () {
      testWidgets('should maintain state after multiple interactions', (tester) async {
        await tester.pumpWidget(buildTestWidget());
        await tester.pumpAndSettle();

        // Get the cubit
        final cubit = BlocProvider.of<AppearanceCubit>(
          tester.element(find.byType(DateTimeSettingsWidget)),
        );

        // Toggle time format
        await tester.tap(find.byType(Toggle));
        await tester.pumpAndSettle();

        // Change date format
        await tester.tap(find.byType(AppDropDownWidget<String>));
        await tester.pumpAndSettle();
        await tester.tap(find.text('ISO').last);
        await tester.pumpAndSettle();

        // Verify final state
        expect(cubit.state.timeFormat, '24h');
        expect(cubit.state.dateFormat, 'ISO');

        // Toggle time format again
        await tester.tap(find.byType(Toggle));
        await tester.pumpAndSettle();

        // State should update correctly
        expect(cubit.state.timeFormat, '12h');
        expect(cubit.state.dateFormat, 'ISO'); // Should remain unchanged
      });
    });

    group('State Change Tests', () {
      testWidgets('should update state when time format is toggled', (tester) async {
        await tester.pumpWidget(buildTestWidget());
        await tester.pumpAndSettle();

        // Get the cubit
        final cubit = BlocProvider.of<AppearanceCubit>(
          tester.element(find.byType(DateTimeSettingsWidget)),
        );

        // Initial state check
        expect(cubit.state.timeFormat, equals('12h'));

        // Toggle time format
        await tester.tap(find.byType(Toggle));
        await tester.pumpAndSettle();

        // Verify state changed
        expect(cubit.state.timeFormat, equals('24h'));
      });

      testWidgets('should update state when date format is changed', (tester) async {
        await tester.pumpWidget(buildTestWidget());
        await tester.pumpAndSettle();

        // Get the cubit
        final cubit = BlocProvider.of<AppearanceCubit>(
          tester.element(find.byType(DateTimeSettingsWidget)),
        );

        // Initial state check
        expect(cubit.state.dateFormat, equals('MM/dd/yyyy'));

        // Open dropdown and select date format
        await tester.tap(find.byType(AppDropDownWidget<String>));
        await tester.pumpAndSettle();
        await tester.tap(find.text('ISO').last);
        await tester.pumpAndSettle();

        // Verify state changed
        expect(cubit.state.dateFormat, equals('ISO'));
      });

      testWidgets('should not affect unrelated state', (tester) async {
        await tester.pumpWidget(buildTestWidget());
        await tester.pumpAndSettle();

        // Get the cubit
        final cubit = BlocProvider.of<AppearanceCubit>(
          tester.element(find.byType(DateTimeSettingsWidget)),
        );

        // Store initial font family
        final initialFontFamily = cubit.state.fontFamily;

        // Toggle time format
        await tester.tap(find.byType(Toggle));
        await tester.pumpAndSettle();

        // Change date format
        await tester.tap(find.byType(AppDropDownWidget<String>));
        await tester.pumpAndSettle();
        await tester.tap(find.text('ISO').last);
        await tester.pumpAndSettle();

        // Verify unrelated state remains unchanged
        expect(cubit.state.fontFamily, equals(initialFontFamily));
      });
    });
  });
}
