# Testing Guidelines Template

## Component Test Information
- **Component**: [component_name]
- **Test Type**: [Unit|Widget|Integration]
- **Test File Location**: test/[mirror/path/of/source]_test.dart

## Test Requirements

### MUST TEST ✅
1. Requirement 1
   ```dart
   // Example test implementation
   ```
2. Requirement 2
   ```dart
   // Example test implementation
   ```

### Test Setup
```dart
void main() {
  // Required setup code
  // Required teardown code
}
```

## Test Patterns

### Basic Tests
```dart
test('should [expected behavior]', () {
  // Arrange
  // Act
  // Assert
});
```

### Mock Requirements
```dart
// Required mocks
// How to use mocks
```

### Edge Cases
1. Case: [Description]
   ```dart
   // Test implementation for edge case
   ```

## Common Test Scenarios

### 1. Happy Path
```dart
// Basic working scenario test
```

### 2. Error Cases
```dart
// Error handling test
```

### 3. State Changes [if applicable]
```dart
// State management test
```

## Quick Reference
```dart
// Most common test pattern
// Copy-paste ready
```

---
Last Updated: [YYYY-MM-DD] 