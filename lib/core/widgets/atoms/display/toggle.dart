import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

// =============================================================================
// CONFIG CLASS FOR STYLING
// =============================================================================

/// Configuration for the styling and layout of the [Toggle] widget.
class ToggleConfig {
  const ToggleConfig({
    // Layout
    required this.height,
    required this.width,
    required this.thumbRadius,
    required this.padding,

    // Animation
    required this.animationDuration,

    // Colors
    required this.activeBackgroundColor,
    required this.inactiveBackgroundColor,
    required this.activeThumbColor,
    required this.inactiveThumbColor,
  });

  /// Creates a large-sized toggle configuration.
  ///
  /// This factory is ideal for desktop applications or areas where the toggle
  /// needs to be a prominent UI element.
  factory ToggleConfig.big(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ToggleConfig(
      height: 26,
      width: 47,
      thumbRadius: 24,
      padding: const EdgeInsets.all(8),
      animationDuration: const Duration(milliseconds: 150),
      activeBackgroundColor: colorScheme.primary,
      inactiveBackgroundColor: colorScheme.onPrimary,
      activeThumbColor: colorScheme.onPrimary,
      inactiveThumbColor: colorScheme.outline,
    );
  }

  /// Creates a small-sized toggle configuration.
  ///
  /// This is suitable for compact UIs where space is limited.
  factory ToggleConfig.small(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ToggleConfig(
      height: 10,
      width: 16,
      thumbRadius: 8,
      padding: const EdgeInsets.all(8),
      animationDuration: const Duration(milliseconds: 150),
      activeBackgroundColor: colorScheme.primary,
      inactiveBackgroundColor: colorScheme.onPrimary,
      activeThumbColor: colorScheme.onPrimary,
      inactiveThumbColor: colorScheme.outline,
    );
  }

  /// Creates a mobile-sized toggle configuration.
  ///
  /// Optimized for touch-based interfaces with standard mobile dimensions.
  factory ToggleConfig.mobile(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    return ToggleConfig(
      height: 24,
      width: 42,
      thumbRadius: 18,
      padding: const EdgeInsets.all(8),
      animationDuration: const Duration(milliseconds: 150),
      activeBackgroundColor: colorScheme.primary,
      inactiveBackgroundColor: colorScheme.onPrimary,
      activeThumbColor: colorScheme.onPrimary,
      inactiveThumbColor: colorScheme.outline,
    );
  }

  /// The total height of the toggle switch.
  final double height;

  /// The total width of the toggle switch.
  final double width;

  /// The radius of the circular thumb.
  final double thumbRadius;

  /// The padding around the toggle switch.
  final EdgeInsets padding;

  /// The duration of the toggle animation.
  final Duration animationDuration;

  /// The background color of the toggle when it is in the "on" or active state.
  final Color activeBackgroundColor;

  /// The background color of the toggle when it is in the "off" or inactive state.
  final Color inactiveBackgroundColor;

  /// The color of the thumb when the toggle is in the "on" or active state.
  final Color activeThumbColor;

  /// The color of the thumb when the toggle is in the "off" or inactive state.
  final Color inactiveThumbColor;
}

// =============================================================================
// TOGGLE WIDGET
// =============================================================================

/// A customizable animated toggle switch widget.
///
/// This widget provides a simple on/off switch, with its appearance defined by
/// the [ToggleConfig]. The state of the toggle is controlled by the `value`
/// and the `onChanged` callback.
class Toggle extends HookWidget {
  const Toggle({
    required this.value,
    required this.onChanged,
    required this.config,
    super.key,
  });

  /// Determines the current state of the toggle. `true` for on, `false` for off.
  final bool value;

  /// A callback function that is invoked when the user taps on the toggle.
  ///
  /// The new boolean state of the toggle is passed as the `value` argument.
  final void Function({required bool value}) onChanged;

  /// The configuration object that defines the visual appearance of the toggle.
  final ToggleConfig config;

  @override
  Widget build(BuildContext context) {
    final isToggled = useState(value);

    // This effect ensures the internal state is always in sync with the parent's state.
    useEffect(
      () {
        isToggled.value = value;
        return null;
      },
      [value],
    );

    // Determines the background color of the toggle based on its state.
    final toggleBackgroundColor =
        isToggled.value ? config.activeBackgroundColor : config.inactiveBackgroundColor;

    // Determines the color of the thumb based on the toggle's state.
    final thumbColor =
        isToggled.value ? config.activeThumbColor : config.inactiveThumbColor;

    return GestureDetector(
      onTap: () {
        isToggled.value = !isToggled.value;
        onChanged(value: isToggled.value);
      },
      child: Padding(
        padding: config.padding,
        child: Stack(
          children: [
            Container(
              height: config.height,
              width: config.width,
              decoration: BoxDecoration(
                color: toggleBackgroundColor,
                borderRadius: BorderRadius.circular(config.height / 2),
              ),
            ),
            AnimatedPositioned(
              duration: config.animationDuration,
              top: (config.height - config.thumbRadius) / 2,
              left: isToggled.value ? config.width - config.thumbRadius - 1 : 1,
              child: Container(
                height: config.thumbRadius,
                width: config.thumbRadius,
                decoration: BoxDecoration(
                  color: thumbColor,
                  borderRadius: BorderRadius.circular(config.thumbRadius / 2),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
