# Theme Upload Testing

This directory contains comprehensive tests for the theme upload functionality.

## 📁 Test Structure

```
test/
├── fixtures/
│   └── themes/
│       ├── test_theme.theme_design/
│       │   ├── light.json
│       │   └── dark.json
│       └── forest_green_test.theme_design/
│           ├── light.json
│           └── dark.json
└── theme_system.dart/
    └── theme/
        ├── theme_upload_test.dart
        └── README.md (this file)
```

## 🧪 Test Categories

### 1. **Test Theme Validation**
- Validates that test theme directories exist
- Checks for required `light.json` and `dark.json` files
- Ensures proper directory structure

### 2. **JSON Structure Validation**
- Validates JSON syntax and structure
- Checks all required color schemes exist
- Validates color format (hex codes)
- Ensures theme name consistency

### 3. **Theme Decoder Tests**
- Tests `ThemeSetDecoder` with real theme files
- Validates successful theme parsing
- Tests error handling for invalid themes

### 4. **Integration Tests**
- Tests `AppearanceCubit.uploadTheme()` functionality
- Validates complete theme upload workflow
- Tests error scenarios (permissions, corruption, etc.)

## 🚀 Running the Tests

### Run All Theme Upload Tests
```bash
flutter test test/theme_system.dart/theme/theme_upload_test.dart
```

### Run Specific Test Groups
```bash
# Test theme validation only
flutter test test/theme_system.dart/theme/theme_upload_test.dart --name "Test Theme Validation"

# Test JSON structure only
flutter test test/theme_system.dart/theme/theme_upload_test.dart --name "Theme JSON Structure Validation"

# Test integration only
flutter test test/theme_system.dart/theme/theme_upload_test.dart --name "Theme Upload Integration Tests"
```

### Run with Verbose Output
```bash
flutter test test/theme_system.dart/theme/theme_upload_test.dart --reporter=expanded
```

## 🎨 Test Themes

### **Test Theme**
- **Purpose**: Basic theme for testing standard functionality
- **Colors**: Blue/gray color scheme with proper contrast
- **Features**: Complete color scheme, modern design

### **Forest Green Theme**
- **Purpose**: Alternative theme to test color variations
- **Colors**: Green/earth tones with natural feel
- **Features**: Different color palette, earth-inspired design

## ✅ What These Tests Validate

1. **File Structure Integrity**
   - Theme directories exist and are properly structured
   - Required JSON files are present and readable

2. **JSON Schema Compliance**
   - All required color schemes are present
   - Color values are in valid hex format
   - Theme names follow proper conventions

3. **Theme Decoder Functionality**
   - Successful parsing of valid themes
   - Proper error handling for invalid themes
   - Correct `AppThemeSet` object creation

4. **Upload Workflow**
   - Complete theme upload process
   - Error handling for various scenarios
   - Integration with `AppearanceCubit`

## 🛠 Adding New Test Themes

To add a new test theme:

1. Create a new directory: `test/fixtures/themes/your_theme.theme_design/`
2. Add `light.json` and `dark.json` with valid theme data
3. Update the test file to include your new theme
4. Run tests to validate the new theme

## 📋 Test Results Checklist

When all tests pass, you can be confident that:

- ✅ Theme upload UI will work correctly
- ✅ Theme files are properly structured
- ✅ Color schemes are valid and complete
- ✅ Error handling works for edge cases
- ✅ Integration with the app's theme system is functional

## 🐛 Troubleshooting

### Common Issues:

1. **Test theme files not found**
   - Ensure `test/fixtures/themes/` directory exists
   - Check that theme directories have the `.theme_design` extension

2. **JSON parsing errors**
   - Validate JSON syntax in theme files
   - Ensure all required color schemes are present

3. **Mock service issues**
   - Verify mock setup in test cases
   - Check that all required methods are mocked

### Debug Commands:
```bash
# Check if test themes exist
ls -la test/fixtures/themes/

# Validate JSON syntax
cat test/fixtures/themes/test_theme.theme_design/light.json | jq .

# Run tests with debug output
flutter test test/theme_system.dart/theme/theme_upload_test.dart --verbose
``` 