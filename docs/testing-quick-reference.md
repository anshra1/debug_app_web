# Flutter Integration Testing Quick Reference

## Quick Setup Checklist

1. **File Setup**
   - [ ] `IntegrationTestWidgetsFlutterBinding.ensureInitialized();`
   - [ ] All required imports
   - [ ] Main group defined
   - [ ] Setup variables declared

2. **Theme Setup**
   - [ ] Using `AppThemeSet` with `AppDefaultTheme`
   - [ ] Not manually constructing theme
   - [ ] Theme properly wrapped in widget tree

3. **State Management**
   - [ ] Using `BlocProvider.of` for state access
   - [ ] State tracking in place
   - [ ] Initial state verified
   - [ ] State changes tracked

4. **Widget Structure**
   - [ ] MaterialApp → Material → AppTheme → BlocProvider → Widget
   - [ ] All necessary providers included
   - [ ] Rebuild tracking implemented

5. **Test Groups**
   - [ ] Rendering Tests
   - [ ] Interaction Tests
   - [ ] State Tests
   - [ ] Edge Cases

## Common Commands

```bash
# Run test on Linux
flutter test integration_test/your_widget_test.dart -d linux

# Run with verbose output
flutter test integration_test/your_widget_test.dart -d linux --verbose
```

## Quick Copy Templates

### Basic Test Structure
```dart
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Widget Tests', () {
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
              create: (context) => YourCubit(),
              child: YourWidget(),
            ),
          ),
        ),
      );
    }

    testWidgets('should ...', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pumpAndSettle();
    });
  });
}
```

### Debug Print Template
```dart
print('''
=== Test Step: ${description} ===
State: ${cubit.state}
Rebuild Count: $rebuildCount
Action: $action
Expected: $expected
Actual: $actual
===
''');
```

## Common Mistakes Checklist

- [ ] Missing `pumpAndSettle` after actions
- [ ] Incorrect state management access
- [ ] Manual theme construction
- [ ] Hard-coded delays
- [ ] Missing edge case tests
- [ ] Insufficient debug output
- [ ] Improper widget tree structure
- [ ] Missing initial state verification

## Quick Debug Tips

1. Add print statements before/after state changes
2. Track widget rebuilds
3. Verify widget tree structure
4. Check initial states
5. Test edge cases
6. Use proper finder methods

## Emergency Fixes

If test fails:
1. Check debug output
2. Verify widget tree
3. Check state management
4. Verify theme setup
5. Add more print statements
6. Check for timing issues 