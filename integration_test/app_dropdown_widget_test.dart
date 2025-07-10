import 'package:debug_app_web/core/widgets/atoms/inputs/app_dropdown_widget.dart';
import 'package:debug_app_web/features/setting/workspace/models/app_theme_set.dart';
import 'package:debug_app_web/features/setting/workspace/theme/app_default_theme.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:theme_ui_widgets/app_theme.dart';
import 'package:theme_ui_widgets/theme/definition/app_theme_data.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('AppDropDownWidget Integration Tests', () {
    late List<SimpleDropdownItem<String>> items;
    late AppThemeData themeData;

    setUp(() {
      items = [
        const SimpleDropdownItem('Option 1', 'value1'),
        const SimpleDropdownItem('Option 2', 'value2'),
        SimpleDropdownItem(
          'Option 3',
          'value3',
          suffixIcon: const Icon(Icons.edit),
          onSuffixIconTap: () {},
        ),
      ];

      final themeSet = AppThemeSet(
        isInbuilt: true,
        themeName: 'Test Theme',
        lightThemeColors: AppDefaultTheme().light(),
        darkThemeColors: AppDefaultTheme().dark(),
      );
      themeData = themeSet.getLightTheme();
    });

    Widget buildTestApp({
      required List<SimpleDropdownItem<String>> dropdownItems,
      String? selectedValue,
      bool enabled = true,
      String? errorText,
      bool showClearButton = false,
      String? label,
      bool isRequired = false,
      Widget? leadingIcon,
      VoidCallback? onSuffixIconTap,
    }) {
      return MaterialApp(
        home: Material(
          child: AppTheme(
            data: themeData,
            child: Builder(
              builder: (context) {
                return Scaffold(
                  body: Center(
                    child: SizedBox(
                      width: 300,
                      child: AppDropDownWidget<String>(
                        items: dropdownItems,
                        selectedValue: selectedValue,
                        onChanged: (_) {},
                        config: AppDropdownWidgetConfig.defaultConfig(context),
                        hint: 'Select an option',
                        enabled: enabled,
                        errorText: errorText,
                        showClearButton: showClearButton,
                        label: label,
                        isRequired: isRequired,
                        leadingIcon: leadingIcon,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    }

    testWidgets('should display initial state correctly', (tester) async {
      await tester.pumpWidget(buildTestApp(dropdownItems: items));
      await tester.pumpAndSettle();

      // Verify dropdown button is rendered
      expect(find.byType(AppDropDownWidget<String>), findsOneWidget);

      // Verify hint text is displayed when no selection
      expect(find.text('Select an option'), findsOneWidget);

      // Verify dropdown is closed initially
      expect(find.text('Option 1'), findsNothing);
      expect(find.text('Option 2'), findsNothing);
      expect(find.text('Option 3'), findsNothing);
    });

    testWidgets('should open dropdown menu on tap', (tester) async {
      await tester.pumpWidget(buildTestApp(dropdownItems: items));
      await tester.pumpAndSettle();

      // Tap the dropdown
      await tester.tap(find.byType(GestureDetector).first);
      await tester.pumpAndSettle();

      // Verify menu is open
      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 2'), findsOneWidget);
      expect(find.text('Option 3'), findsOneWidget);

      // Close dropdown
      await tester.tapAt(const Offset(0, 0));
      await tester.pumpAndSettle();
    });

    testWidgets('should show selected value', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          dropdownItems: items,
          selectedValue: 'Option 1',
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Option 1'), findsOneWidget);
    });

    testWidgets('should handle disabled state', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          dropdownItems: items,
          enabled: false,
        ),
      );
      await tester.pumpAndSettle();

      // Tap the dropdown
      await tester.tap(find.byType(GestureDetector).first);
      await tester.pumpAndSettle();

      // Verify menu is not open
      expect(find.text('Option 1'), findsNothing);
    });

    testWidgets('should show error text when provided', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          dropdownItems: items,
          errorText: 'This field is required',
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('This field is required'), findsOneWidget);
    });

    testWidgets('should show clear button when enabled', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          dropdownItems: items,
          selectedValue: 'Option 1',
          showClearButton: true,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.clear), findsOneWidget);
    });

    testWidgets('should show label and required indicator', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          dropdownItems: items,
          label: 'Test Label',
          isRequired: true,
        ),
      );
      await tester.pumpAndSettle();

      // Find the RichText widget containing the label
      final richTextFinder = find.byWidgetPredicate((widget) {
        if (widget is RichText) {
          final textSpan = widget.text as TextSpan;
          return textSpan.text == 'Test Label' && textSpan.children?.length == 1;
        }
        return false;
      });
      expect(richTextFinder, findsOneWidget);

      final richText = tester.widget<RichText>(richTextFinder);
      final textSpan = richText.text as TextSpan;
      expect(textSpan.text, 'Test Label');

      // Find the required indicator
      final requiredIndicator = textSpan.children!.first as TextSpan;
      expect(requiredIndicator.text, ' *');
    });

    testWidgets('should show leading icon when provided', (tester) async {
      await tester.pumpWidget(
        buildTestApp(
          dropdownItems: items,
          leadingIcon: const Icon(Icons.person),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.person), findsOneWidget);
    });

    testWidgets('should handle suffix icon tap', (tester) async {
      var suffixTapped = false;
      await tester.pumpWidget(
        buildTestApp(
          dropdownItems: [
            SimpleDropdownItem(
              'Option 1',
              'value1',
              suffixIcon: const Icon(Icons.edit),
              onSuffixIconTap: () => suffixTapped = true,
            ),
          ],
        ),
      );
      await tester.pumpAndSettle();

      // Open dropdown
      await tester.tap(find.byType(GestureDetector).first);
      await tester.pumpAndSettle();

      // Tap suffix icon
      await tester.tap(find.byIcon(Icons.edit));
      await tester.pumpAndSettle();

      // Close dropdown
      await tester.tapAt(const Offset(0, 0));
      await tester.pumpAndSettle();

      expect(suffixTapped, isTrue);
    });

    testWidgets('should close dropdown when tapping outside', (tester) async {
      await tester.pumpWidget(buildTestApp(dropdownItems: items));
      await tester.pumpAndSettle();

      // Open dropdown
      await tester.tap(find.byType(GestureDetector).first);
      await tester.pumpAndSettle();

      // Verify menu is open
      expect(find.text('Option 1'), findsOneWidget);

      // Tap outside
      await tester.tapAt(const Offset(0, 0));
      await tester.pumpAndSettle();

      // Verify menu is closed
      expect(find.text('Option 1'), findsNothing);
    });

    testWidgets('should handle keyboard focus', (tester) async {
      await tester.pumpWidget(buildTestApp(dropdownItems: items));
      await tester.pumpAndSettle();

      // Set focus using keyboard
      await tester.sendKeyEvent(LogicalKeyboardKey.tab);
      await tester.pumpAndSettle();

      // Verify focus ring is displayed
      final focusNode = tester.widget<Focus>(find.byType(Focus).first).focusNode!;
      expect(focusNode.hasFocus, isTrue);
    });

    testWidgets('should handle hover states', (tester) async {
      await tester.pumpWidget(buildTestApp(dropdownItems: items));
      await tester.pumpAndSettle();

      // Hover over dropdown
      final gesture = await tester.createGesture(kind: PointerDeviceKind.mouse);
      await gesture.addPointer(location: Offset.zero);
      await gesture.moveTo(tester.getCenter(find.byType(GestureDetector).first));
      await tester.pumpAndSettle();

      // Visual verification would require checking specific colors/styles
      // which can be done by finding specific widgets and checking their properties

      // Cleanup
      await gesture.removePointer();
    });

    testWidgets('should handle max height constraint', (tester) async {
      // Create a list of many items
      final manyItems = List.generate(
        20,
        (index) => SimpleDropdownItem('Option ${index + 1}', 'value${index + 1}'),
      );

      await tester.pumpWidget(buildTestApp(dropdownItems: manyItems));
      await tester.pumpAndSettle();

      // Open dropdown
      await tester.tap(find.byType(GestureDetector).first);
      await tester.pumpAndSettle();

      // Verify that not all items are visible at once
      expect(find.text('Option 1'), findsOneWidget);
      expect(find.text('Option 20'), findsNothing);

      // Close dropdown
      await tester.tapAt(const Offset(0, 0));
      await tester.pumpAndSettle();
    });
  });
}
