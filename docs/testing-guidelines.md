# Flutter Integration Testing Guidelines

## 1. Test File Structure

### 1.1 Basic Template
```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
// Add your imports here

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('YourWidget Integration Tests', () {
    // Setup variables
    late AppThemeData themeData;
    late int rebuildCount;

    // Setup function
    setUp(() {
      setupTheme();
      resetCounters();
    });

    // Widget builders
    Widget buildTestWidget() { ... }
    Widget buildTrackerWidget() { ... }

    // Test groups
    group('Rendering Tests', () { ... });
    group('Interaction Tests', () { ... });
    group('State Tests', () { ... });
  });
}
```

### 1.2 Required Imports
```dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart' // If using Bloc
import 'package:theme_ui_widgets/theme/app_theme.dart';
```

## 2. Theme Setup

### 2.1 Standard Theme Setup
```dart
setUp(() {
  final themeSet = AppThemeSet(
    isInbuilt: true,
    themeName: 'Test Theme',
    lightThemeColors: AppDefaultTheme().light(),
    darkThemeColors: AppDefaultTheme().dark(),
  );
  themeData = themeSet.getLightTheme();
});
```

### 2.2 Widget Tree Setup
```dart
Widget buildTestWidget() {
  return MaterialApp(
    home: Material(
      child: AppTheme(
        data: themeData,
        child: BlocProvider(
          create: (context) => YourCubit(),
          child: YourWidget(),
        ),
      ),
    ),
  );
}
```

## 3. State Management

### 3.1 Accessing State
```dart
// ✅ Correct way to access Bloc/Cubit
final cubit = BlocProvider.of<YourCubit>(
  tester.element(find.byType(YourWidget))
);

// ❌ Never do this
final cubit = tester.widget<YourCubit>(...);
```

### 3.2 State Tracking
```dart
Widget buildTrackerWidget() {
  return Builder(
    builder: (context) {
      print('\n=== Build #${++rebuildCount} ===');
      print('Current State: ${cubit.state}');
      print('Trigger: ${tester.binding.currentTestDescription}');
      return YourWidget();
    },
  );
}
```

## 4. Test Categories

### 4.1 Rendering Tests
```dart
group('Rendering Tests', () {
  testWidgets('should render initial state correctly', (tester) async {
    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    // Verify all widgets are present
    expect(find.byType(YourWidget), findsOneWidget);
    expect(find.text('Expected Text'), findsOneWidget);
    // Add more widget checks
  });
});
```

### 4.2 Interaction Tests
```dart
group('Interaction Tests', () {
  testWidgets('should handle user interaction', (tester) async {
    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    // Perform interaction
    await tester.tap(find.byType(Button));
    await tester.pumpAndSettle();

    // Verify results
    expect(find.text('New State'), findsOneWidget);
  });
});
```

### 4.3 State Management Tests
```dart
group('State Tests', () {
  testWidgets('should update state correctly', (tester) async {
    await tester.pumpWidget(buildTestWidget());
    await tester.pumpAndSettle();

    final cubit = BlocProvider.of<YourCubit>(
      tester.element(find.byType(YourWidget))
    );

    // Initial state
    expect(cubit.state.someValue, equals(initialValue));

    // Perform action
    await tester.tap(find.byType(Button));
    await tester.pumpAndSettle();

    // Verify state change
    expect(cubit.state.someValue, equals(newValue));
  });
});
```

## 5. Debug Tracking

### 5.1 Rebuild Tracking
```dart
var rebuildCount = 0;

print('''
=== Test Step: ${tester.binding.currentTestDescription} ===
Rebuild Count: ${++rebuildCount}
Current State: ${cubit.state}
Action: $currentAction
===
''');
```

### 5.2 State Change Tracking
```dart
testWidgets('should track state changes', (tester) async {
  print('\n--- Starting State Test ---');
  
  // Before state
  print('Initial State: ${cubit.state}');
  
  // Action
  await tester.tap(find.byType(Button));
  await tester.pumpAndSettle();
  
  // After state
  print('Final State: ${cubit.state}');
  print('--- Test Complete ---\n');
});
```

## 6. Best Practices

### 6.1 Async Operations
- Always use `await tester.pumpAndSettle()` after actions
- Use `tester.runAsync()` for real async operations
- Handle timeouts appropriately

### 6.2 Widget Finding
```dart
// Preferred order of finder methods:
1. find.byKey(ValueKey('unique_key'))
2. find.byType(WidgetType)
3. find.text('Exact Text')
4. find.textContaining('Partial Text')
```

### 6.3 Error Prevention
- Verify initial state before actions
- Check widget existence before interaction
- Use proper pump methods
- Handle edge cases
- Test error states

## 7. Documentation

### 7.1 Test Description
```dart
testWidgets('''
should handle complex interaction
GIVEN: Initial state X
WHEN: User performs action Y
THEN: State should be Z
AND: UI should show W
''', (tester) async { ... });
```

### 7.2 Comments
```dart
// SETUP - Describe setup steps
// ACTION - Describe user action
// VERIFY - Describe verification steps
```

## 8. Common Pitfalls to Avoid

1. ❌ Don't manually construct theme data
2. ❌ Don't skip pumpAndSettle after actions
3. ❌ Don't use hard-coded delays
4. ❌ Don't access state management incorrectly
5. ❌ Don't make assumptions about initial state

## 9. Running Tests

### 9.1 Command
```bash
flutter test integration_test/your_widget_test.dart -d linux
```

### 9.2 Debug Output
- Use clear, structured print statements
- Include timestamps for async operations
- Log all state changes
- Track rebuild counts

## 10. Checklist Before Running

✓ All necessary imports are present
✓ Theme is properly set up
✓ Widget tree is complete
✓ State management is properly initialized
✓ All actions have proper pump calls
✓ Debug tracking is in place
✓ Edge cases are covered
✓ Documentation is clear 