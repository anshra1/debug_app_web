You are absolutely right. My apologies. I will perform a more thorough analysis of the entire codebase to provide a complete and accurate guide.

First, I will list all the files to ensure I don't miss any.
```bash
ls -R
```

Excellent, that gives me a much better overview. Now, I will read the core files of the `toastification` package to build a comprehensive understanding of its functionality. I'll start with the main `toastification.dart` file and then proceed to the other core components.
Read file: package/toastification-main/lib/toast_src/built_in/built_in_builder.dart

Okay, I've reviewed the `BuiltInBuilder`. Now, I will proceed to read the next set of files to continue building a complete picture of the `toastification` package.
Read file: package/toastification-main/lib/toast_src/built_in/layout/standard/style/factory.dart

Understood. I've examined the `StandardToastStyleFactory`. Now, I'll proceed with the next batch of files to continue my analysis of the `toastification` package.
Read file: package/toastification-main/lib/toast_src/built_in/layout/standard/style/implementation/filled_style.dart

Okay, `FilledStandardToastStyle` is clear. I will now proceed to the next set of files to continue building my understanding of the `toastification` library.
Read file: package/toastification-main/lib/toast_src/built_in/layout/standard/style/implementation/flat_colored_style.dart

Right, `FlatStandardColoredToastStyle` is done. On to the next file to continue my analysis.
Read file: package/toastification-main/lib/toast_src/built_in/layout/standard/style/implementation/flat_style.dart

Okay, I've reviewed `FlatStandardToastStyle`. Proceeding to the next file in the `toastification` package to continue my analysis.
Read file: package/toastification-main/lib/toast_src/built_in/layout/standard/style/implementation/minimal_style.dart

`MinimalStandardToastStyle` is clear. I'll now move to the next file in the `toastification` package.
Read file: package/toastification-main/lib/toast_src/built_in/layout/standard/style/implementation/simple_style.dart

Okay, `SimpleStandardToastStyle` is reviewed. I'm moving on to the next file to continue my analysis of the `toastification` package.
Read file: package/toastification-main/lib/toast_src/built_in/layout/standard/style/style.dart

Okay, I've reviewed the base style definitions in `style.dart`. Now I'll proceed with the next set of files to understand how these styles are used to construct the actual toast widgets.
Read file: package/toastification-main/lib/toast_src/built_in/layout/standard/toast/base_standard.dart

Okay, `base_standard.dart` is clear. Now I will continue with the next files to understand the concrete implementations of the standard toast widgets.
Read file: package/toastification-main/lib/toast_src/built_in/layout/standard/toast/default/default_standard_toast.dart

Okay, I've analyzed the `DefaultStandardToastWidget`. Now, I'll proceed to the next file to continue my deep dive into the `toastification` package.
Read file: package/toastification-main/lib/toast_src/built_in/layout/standard/toast/factory.dart

Okay, the `StandardToastWidgetFactory` is clear. I'll now examine the `MinimalStandardToastWidget` to understand its specific implementation.
Read file: package/toastification-main/lib/toast_src/built_in/layout/standard/toast/minimal/minimal_standard_toast.dart

Okay, I've reviewed the `MinimalStandardToastWidget`. Now I'll examine the `SimpleStandardToastWidget` to understand its implementation.
Read file: package/toastification-main/lib/toast_src/built_in/layout/standard/toast/simple/simple_standard_toast.dart

Okay, I've reviewed the `SimpleStandardToastWidget`. Now I'll move on to the theming aspect, starting with `toastification_theme.dart`.
Read file: package/toastification-main/lib/toast_src/built_in/theme/toastification_theme.dart

Okay, `ToastificationTheme` is clear. Now I'll examine `ToastificationThemeData` to understand the specific theme properties.
Read file: package/toastification-main/lib/toast_src/built_in/theme/toastification_theme_data.dart

Okay, I've reviewed `ToastificationThemeData`. Now I will examine `toastification_style.dart` to understand the available styling options.
Read file: package/toastification-main/lib/toast_src/built_in/toastification_style.dart

I have now analyzed the core components of the `toastification` package, including the builders, factories, styles, themes, and different toast widgets. I have a much clearer picture of its architecture and capabilities.

I am ready to generate a revised and much more detailed usage guide.

# 📘 Package Usage Guide: toastification

This guide provides comprehensive instructions for using the `toastification` package in your Flutter projects. It is a highly customizable library for showing toast notifications.

## 1. What This Package Does

The `toastification` package provides a robust and flexible system for displaying in-app notifications (toasts). It is designed to be easy to use for simple cases while offering extensive customization for more complex scenarios.

It solves the problem of needing a consistent, beautiful, and manageable way to show users non-intrusive information, such as success messages, warnings, or errors, without disrupting their workflow. It can be used with or without a `BuildContext`, making it ideal for use in various parts of an application, like view models or services.

## 2. Features and Capabilities

- **Richly Styled Built-in Toasts**: Comes with a set of predefined styles (`flat`, `minimal`, `fillColored`, `flatColored`, `simple`) and types (`info`, `success`, `warning`, `error`).
- **Deep Customization**: Almost every visual aspect can be overridden on a per-toast basis: colors, icons, border radius, shadows, padding, and more.
- **Custom Widget Support**: You are not limited to the built-in styles. `showCustom` allows you to render any widget as a toast notification.
- **Flexible Placement**: Toasts can be placed in 9 different alignments on the screen (e.g., `Alignment.topRight`, `Alignment.bottomCenter`).
- **Interactive Features**: Supports "pause on hover," "drag to close," and "close on click" to improve user experience.
- **Lifecycle Management**: Toasts can auto-close with a visible progress bar. You get a `ToastificationItem` object back when you show a toast, allowing you to programmatically control it (pause, resume, dismiss).
- **Global and Local Configuration**: Configure toasts for your entire app using `ToastificationWrapper` and `ToastificationConfig`, or override settings for individual toasts.
- **Context-Free Usage**: By wrapping your `MaterialApp`, you can call `toastification.show()` from anywhere, without needing access to a `BuildContext`.
- **Custom Animations**: You can define your own show/hide animations for toasts.
- **Callbacks for Events**: Provides callbacks for user interactions like `onTap`, `onCloseButtonTap`, `onDismissed`, and for lifecycle events like `onAutoCompleteCompleted`.
- **Queue and Limit Management**: The package intelligently queues toasts and limits the number of toasts visible at once, preventing screen clutter.

### Public API Surface

- **`toastification` (Singleton)**: The primary entry point for all toast operations.
  - `show()`: Shows a pre-styled toast.
  - `showCustom()`: Shows a custom widget as a toast.
  - `dismiss(ToastificationItem)`: Dismisses a specific toast.
  - `dismissAll()`: Clears all visible toasts.
  - `dismissById(String id)`: Dismisses a toast using its unique ID.
  - `findToastificationItem(String id)`: Retrieves a `ToastificationItem` if it's currently active.
- **Widgets & Configuration**:
  - `ToastificationWrapper`: An essential widget to wrap your `MaterialApp` for context-free usage and global configuration.
  - `ToastificationConfig`: A data class to define the default behavior and look of all toasts (e.g., `alignment`, `itemWidth`, `maxToastLimit`).
- **Enums & Data Models**:
  - `ToastificationType`: Defines the toast's semantic purpose (`info`, `success`, `warning`, `error`). Each has a default color and icon.
  - `ToastificationStyle`: Defines the visual theme of the toast (`minimal`, `fillColored`, etc.).
  - `ToastificationItem`: A handle to a live toast notification, containing its state (`id`, `alignment`, timer status) and allowing for programmatic control.
  - `ToastificationCallbacks`: A container for all the lifecycle callback functions.
  - `ToastCloseButton`: A configuration object for the close button's visibility and appearance.
  - `ToastificationThemeData`: An `InheritedTheme` data object that passes down toast-specific theme information within the widget tree.

## 3. How to Use It

### Step 1: Installation and Setup

First, add the package to your `pubspec.yaml`. Then, for the best experience, wrap your `MaterialApp` with `ToastificationWrapper`. This enables global configuration and context-free showing of toasts.

```dart
// main.dart
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ToastificationWrapper(
      child: MaterialApp(
        title: 'Toastification Demo',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: const MyHomePage(),
      ),
    );
  }
}
```

### Step 2: Showing Toasts

#### Showing a Built-in Toast

Use the global `toastification` instance to call `show()`.

```dart
// From any widget that has a BuildContext
void showSuccessToast(BuildContext context) {
  toastification.show(
    context: context, // context is optional if you use ToastificationWrapper
    type: ToastificationType.success,
    style: ToastificationStyle.fillColored,
    title: const Text('Success!'),
    description: const Text('Your changes have been saved successfully.'),
    alignment: Alignment.topRight,
    autoCloseDuration: const Duration(seconds: 5),
    showProgressBar: true,
    pauseOnHover: true,
    dragToClose: true,
    closeButtonShowType: CloseButtonShowType.onHover,
    callbacks: ToastificationCallbacks(
      onTap: (item) => print('Tapped on ${item.id}'),
    ),
  );
}
```

#### Showing a Custom Toast

Use `showCustom()` for complete control over the UI. The `builder` provides the `ToastificationItem`, which is crucial for features like the auto-close progress bar.

```dart
void showMyAwesomeCustomToast(BuildContext context) {
  toastification.showCustom(
    context: context,
    alignment: Alignment.bottomCenter,
    autoCloseDuration: const Duration(seconds: 4),
    builder: (BuildContext context, ToastificationItem item) {
      return Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('This is a custom toast!', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              // Use the item to build a progress bar
              ToastTimerAnimationBuilder(
                item: item,
                builder: (context, value, __) {
                  return LinearProgressIndicator(value: value);
                },
              ),
            ],
          ),
        ),
      );
    },
  );
}
```

### Step 3: Managing Toasts Programmatically

When you call `show()` or `showCustom()`, a `ToastificationItem` is returned. Use this object to control the toast.

```dart
void demonstrateControl() {
  // Show a toast that will auto-close in 10 seconds.
  final toastItem = toastification.show(
    title: const Text('You can control me!'),
    autoCloseDuration: const Duration(seconds: 10),
  );

  // Pause the timer
  Future.delayed(const Duration(seconds: 2), () {
    toastItem.pause();
    print('Toast paused');
  });

  // Resume the timer
  Future.delayed(const Duration(seconds: 5), () {
    toastItem.start();
    print('Toast resumed');
  });

  // Or dismiss it early
  Future.delayed(const Duration(seconds: 7), () {
    toastification.dismiss(toastItem, showRemoveAnimation: true);
    print('Toast dismissed');
  });
}
```

## 4. Configuration

### Global Configuration

Set app-wide defaults by providing a `ToastificationConfig` to the `ToastificationWrapper`.

```dart
// main.dart
ToastificationWrapper(
  config: const ToastificationConfig(
    alignment: Alignment.bottomRight,
    itemWidth: 440,
    maxToastLimit: 3, // Only 3 toasts will be shown at a time
    animationDuration: Duration(milliseconds: 500),
    blockBackgroundInteraction: false,
    applyMediaQueryViewInsets: true,
  ),
  child: MaterialApp(...),
);
```

### Per-Toast Overrides

You can override any global setting by passing parameters directly to `show()`. This includes both style properties and behavioral configurations via the `config` parameter.

```dart
toastification.show(
  title: const Text('A Very Special Toast'),
  // Override visual properties
  style: ToastificationStyle.minimal,
  primaryColor: Colors.deepPurple,
  backgroundColor: Colors.deepPurple.shade50,
  // Override behavior for just this toast
  config: const ToastificationConfig(
    alignment: Alignment.center,
  ),
);
```

## 5. Best Practices & Key Concepts

- **`ToastificationManager`**: Internally, the package uses a `ToastificationManager` for each `Alignment`. This manager is responsible for queuing, displaying, and dismissing toasts for that specific screen region. You don't interact with it directly, but it's good to know it exists.
- **Immutability and `copyWith`**: Many configuration objects like `ToastCloseButton` and `ToastificationThemeData` are immutable and provide a `copyWith` method for creating modified instances.
- **Factories for Abstraction**: The package uses factories (`StandardToastStyleFactory`, `StandardToastWidgetFactory`) to decouple the creation of style objects and widgets, making the system extensible.
- **Do's**:
  - **Always use `ToastificationWrapper`** at the root of your app.
  - **Define a global `ToastificationConfig`** for UI/UX consistency.
  - **Leverage the built-in types and styles** for common use-cases.
  - **Encapsulate custom toast widgets** to keep your code clean and reusable.
- **Don'ts**:
  - **Don't forget to call `toastification.dismiss(item)`** in your `onCloseButtonTap` callback if you override it, as it replaces the default dismiss behavior.
  - **Avoid excessive per-toast customization** if a global style will do. This improves maintainability.
  - **Be mindful of `autoCloseDuration`**. For important messages that require user action, consider making them persistent by not setting an `autoCloseDuration`.

This more detailed guide should cover all the key aspects of the `toastification` package. Please let me know if you would like me to elaborate on any specific part.