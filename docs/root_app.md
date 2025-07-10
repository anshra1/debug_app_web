# 📘 Documentation for `root_app.dart`



RootApp/
├── MultiBlocProvider/
│   └── BlocProvider<AppearanceCubit>/
│       ├── Responsibilities:
│       │   ├── Theme state management
│       │   ├── Dark/Light mode switching
│       │   └── Font family management
│       │
│       └── ScreenUtilInit/
│           ├── Config:
│           │   ├── Design Size: 1080x1920
│           │   ├── MinTextAdapt: true
│           │   └── SplitScreenMode: true
│           │
│           └── ToastificationWrapper/
│               ├── Features:
│               │   ├── Global toast notifications
│               │   └── Error message display
│               │
│               └── ThemeContainer (HookWidget)/
│                   │
│                   ├── BlocConsumer/
│                   │   ├── ListenWhen:
│                   │   │   └── Error message changes
│                   │   │
│                   │   └── Listener:
│                   │   |     └── ToastService integration
|                   |   |
│                   │   ├── BuildWhen:
│                   │   │   ├── Theme changes
│                   │   │   ├── Mode changes
│                   │   │   └── Font changes
│                   │
│                   └── BlocBuilder: AppTheme/
│                       ├── Features:
│                       │   └── get current AppTheme
│                       │
│                       └── AppMaterialContainer/
│                           ├── Properties:
│                           │   ├── isDark: bool
│                           │   └── appearanceCubit: AppearanceCubit
│                           │
│                           └── AppWrappers/
│                               ├── SystemUIWrapper/
│                               │   └── Style:
│                               │       ├── Light mode: dark icons
│                               │       └── Dark mode: light icons
│                               │
│                               ├── KeyboardDismissWrapper/
│                               │   └── Feature:
│                               │       └── Auto keyboard dismiss
│                               │
│                               └── MaterialApp.router/
│                                   ├── Config:
│                                   │   ├── debugShowCheckedModeBanner: false
│                                   │   ├── title: AppConfig.appName
│                                   │   ├── theme: AppFlutterTheme
│                                   │   └── routerConfig: AppRouter.router
│                                   │
│                                   └── MediaQuery/
│                                       ├── TextScaling:
│                                       │   ├── Min: 0.8
│                                       │   └── Max: 1.2
│                                       │
│                                       ├── PlatformBrightness:
│                                       │   └── Synced with theme
│                                       │
│                                       └── ErrorBoundary/
│                                           └── Feature:
│                                               └── Fallback UI for errors or main app


StateManagement

1. Cubit - AppearanceCubit 
   
  a. Theme Management
     - Set theme by name
     - Upload custom themes (.theme_design files)
     - Delete custom themes (cannot delete inbuilt or active themes)
     - Load inbuilt and imported themes

  b. Theme Mode
     - Set theme mode (light/dark/system)
     - Toggle between light and dark mode
     - Auto-detection of system brightness

  c. Font Settings
     - Set custom font family
     - Apply font to theme data

  d. Format Settings
     - Set date format
     - Toggle time format (12h/24h)
     
  e. Settings Persistence
     - Save/load settings to SharedPreferences
     - Debounced saving for performance
     
  f. Error Handling
     - Structured error messages
     - Loading state management
     - Exception handling for operations

  g. Platform Integration
     - System brightness detection
     - Platform brightness listener
     - Resource cleanup on close


ScreenUtil

 ToastificationWrapper - 
  a. Loading Service

   Read file: lib/core/services/loading_service.dart
   Ran tool
   Based on the earlier reading of the LoadingService file, here's a quick overview:
   
   ## Loading Service Overview
   
   **Purpose:** Centralized loading state management for the application
   
   **Key Features:**
   - Show/hide loading indicators with custom widgets
   - Dynamic message and progress updates
   - Auto-close functionality with configurable duration
   - Single loading indicator enforcement (prevents overlapping)
   
   **Core Methods:**
   - `show()` - Display loading with custom widget and message
   - `update()` - Modify message/progress of active indicator  
   - `hide()` - Dismiss current loading indicator
   - `isShowing` - Check loading state
   
   **Integration:**
   - Built on Toastification framework
   - Uses ValueNotifier for reactive updates
   - Dependency injection via service locator
   - Special handling for ProgressIndicatorWidget
   


This service provides a consistent, user-friendly way to handle loading states across the entire application.

  b. Toast Service
    // Later
 
  c. Dialog Service
    // Later

-----------------------------------------------

ThemeContainer

-----------------------------------------
Read file: package/theme_ui_widgets/lib/theme/app_theme.dart

## AppTheme Overview


**AppTheme** is a custom theme widget from the `theme_ui_widgets` package that provides a centralized way to access design tokens and theme data throughout the app.

**Purpose**: Provides a design system foundation that bridges custom design tokens with Flutter's theming system, ensuring consistent styling across the entire application.

### Key Features:

1. **Context Extension**: Accessible via `context.appTheme` through a custom extension
     ```dart
     extension AppThemeExtension on BuildContext {
       AppThemeData get appTheme => AppTheme.of(this);
     }
     ```

2. **Design Token Access**: Provides structured access to:
   - **Color Schemes**: `textColorScheme`, `fillColorScheme`, `borderColorScheme`, 
                        `surfaceColorScheme`,`backgroundColorScheme`, `iconColorScheme`
   - **Typography**: `textStyle` with various sizes (bodyMedium, titleLarge, etc.)
   - **Spacing**: `spacing` tokens (xs, s, m, l, etc.)
   - **Border Radius**: `borderRadius` tokens

3. **Flutter Theme Conversion**: The `AppFlutterTheme` class converts AppTheme tokens to Flutter's native `ThemeData`:
   - Maps custom color tokens to Material 3 `ColorScheme`
   - Applies typography and spacing consistently
   - Handles component-specific theming (buttons, inputs, cards, etc.)

4. **Usage in Components**: Widgets like `AppDropdownWidget` and `AppHeaderWidget` use it for consistent styling:
     ```dart
     final theme = AppTheme.of(context);
     final textColor = theme.textColorScheme.primary;
     final spacing = theme.spacing.m;
     ```

5. **Integration**: Works alongside the `AppearanceCubit` for dynamic theme switching and is converted to Flutter's ThemeData for Material components.


-----------------------

AppMaterial Container
  - AppWrapper
      a. SystemUIWrapper
      b. KeyboardDismissWrapper

ErrorBoundary