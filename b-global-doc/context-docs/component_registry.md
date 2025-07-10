# Project Component Registry

**Last Updated:** 2024-03-20

## Project Patterns
- Services use dependency injection via getIt
- Widgets follow atomic design
- Managers are typically singletons & static
- Utils are static classes

## Directory Structure
| Category | Path |
|----------|------|
| Services | `lib/core/services/` |
| Managers | `lib/core/manager/` |
| Widgets | `lib/core/widgets/` |
| Utils | `lib/core/utils/` |
| Extensions | `lib/core/utils/extensions/` |
| Helpers | `lib/core/utils/helpers/` |

## Quick Reference
```
SERVICES_PATH: lib/core/services/
MANAGERS_PATH: lib/core/manager/
WIDGETS_PATH: lib/core/widgets/
UTILS_PATH: lib/core/utils/
EXTENSIONS_PATH: lib/core/utils/extensions/
```

## Services

### LoadingService
- **Path:** `lib/core/services/loading_service.dart`
- **Description:** Displays and manages centralized loading indicators with progress updates using toast 
    notifications. Ensures only one loading indicator is shown at a time.
- **Dependencies:** Toastification
- **Platforms:** web, android, ios, macos, linux, windows
- **Test:** `test/core/services/loading_service_test.dart`

### ToastService
- **Path:** `lib/core/services/toast_service.dart`
- **Description:** Manages toast notifications with customizable styles and durations
- **Dependencies:** Toastification
- **Platforms:** web, android, ios, macos, linux, windows
- **Test:** `test/core/services/toast_service_test.dart`

## Managers

### InternetConnectionManager
- **Path:** `lib/core/manager/internet_manager.dart`
- **Description:** Monitors network connectivity status
- **Type:** Singleton
- **Platforms:** web, android, ios, macos, linux, windows
- **Test:** `test/core/manager/internet_manager_test.dart`

## Reusable Widgets

### CustomButton
- **Path:** `lib/core/widgets/atoms/custom_button.dart`
- **Description:** Standard button component
- **Category:** atoms
- **Platforms:** web, android, ios, macos, linux, windows
- **Test:** `test/core/widgets/atoms/custom_button_test.dart`

## Extensions

### StringExtensions
- **Path:** `lib/core/utils/extensions/string_extensions.dart`
- **Description:** String manipulation utilities
- **Extends:** String
- **Platforms:** all
- **Test:** `test/core/utils/extensions/string_extensions_test.dart`

## Utils

### ValidationUtils
- **Path:** `lib/core/utils/utils/validation_utils.dart`
- **Description:** Form and input validation functions
- **Type:** Static
- **Platforms:** all
- **Test:** `test/core/utils/utils/validation_utils_test.dart`

## Helpers

### DateFormatter
- **Path:** `lib/core/utils/helpers/date_formatter.dart`
- **Description:** Date formatting utilities
- **Format:** Static class
- **Platforms:** all
- **Test:** `test/core/utils/helpers/date_formatter_test.dart`

## Important Notes
- All services are registered in `lib/core/di/dependency_injection.dart`
- Widgets follow atomic design pattern (atoms -> molecules -> organisms)
- Extensions are used through import statements
- Manager classes are typically singletons or sometime static 