import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:theme_ui_widgets/theme_ui_widgets.dart' show AppTheme;

// =============================================================================
// CONFIG CLASS FOR STYLING
// =============================================================================

class SidebarItemWidgetConfig {
  const SidebarItemWidgetConfig({
    // Layout
    required this.padding,
    required this.borderRadius,
    required this.spacing,
    required this.iconSize,

    // Colors - Normal State
    required this.backgroundColor,
    required this.borderColor,
    required this.textColor,

    // Colors - Hover State
    required this.hoverBackgroundColor,
    required this.hoverBorderColor,
    required this.hoverTextColor,

    // Colors - Selected State
    required this.selectedBackgroundColor,
    required this.selectedBorderColor,
    required this.selectedTextColor,

    // Colors - Disabled State
    required this.disabledBackgroundColor,
    required this.disabledBorderColor,
    required this.disabledTextColor,

    // Focus Ring
    required this.focusRingColor,

    // Text Styles
    required this.textStyleNormal,
    required this.textStyleHover,
    required this.textStyleSelected,
    required this.textStyleDisabled,

    // Animation
    required this.animationDuration,
    required this.animationCurve,
  });

  /// Default config based on AppThemeData from context
  factory SidebarItemWidgetConfig.defaultConfig(BuildContext context) {
    final theme = AppTheme.of(context); // Get full AppThemeData
    final fill = theme.fillColorScheme;
    final text = theme.textColorScheme;

    return SidebarItemWidgetConfig(
      // Layout
      padding: const EdgeInsets.all(12),
      borderRadius: theme.borderRadius.m,
      spacing: theme.spacing.m,
      iconSize: 20,

      // Colors - Normal
      backgroundColor: Colors.transparent,
      borderColor: Colors.transparent,
      textColor: text.primary,

      // Colors - Hover
      hoverBackgroundColor: fill.primaryHover,
      hoverBorderColor: Colors.transparent,
      hoverTextColor: text.primary,

      // Colors - Selected
      selectedBackgroundColor: fill.themeSelect,
      selectedBorderColor: Colors.transparent,
      selectedTextColor: text.primary,

      // Colors - Disabled
      disabledBackgroundColor: Colors.transparent,
      disabledBorderColor: Colors.transparent,
      disabledTextColor: text.quaternary,

      // Focus Ring
      focusRingColor: fill.themeThick,

      // Text Styles - AppTheme now contains user's font choice
      textStyleNormal:
          theme.textStyle.labelLarge.standard(context: context, color: text.primary),
      textStyleHover:
          theme.textStyle.labelLarge.standard(context: context, color: text.primary),
      textStyleSelected:
          theme.textStyle.labelLarge.standard(context: context, color: text.primary),
      textStyleDisabled:
          theme.textStyle.labelLarge.standard(context: context, color: text.quaternary),

      // Animation
      animationDuration: const Duration(milliseconds: 200),
      animationCurve: Curves.easeInOut,
    );
  }

  // Layout Properties
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final double spacing;
  final double iconSize;

  // Background / Border / Text Colors
  final Color backgroundColor;
  final Color borderColor;
  final Color textColor;

  final Color hoverBackgroundColor;
  final Color hoverBorderColor;
  final Color hoverTextColor;

  final Color selectedBackgroundColor;
  final Color selectedBorderColor;
  final Color selectedTextColor;

  final Color disabledBackgroundColor;
  final Color disabledBorderColor;
  final Color disabledTextColor;

  final Color focusRingColor;

  // Text Styles per State
  final TextStyle textStyleNormal;
  final TextStyle textStyleHover;
  final TextStyle textStyleSelected;
  final TextStyle textStyleDisabled;

  // Animation
  final Duration animationDuration;
  final Curve animationCurve;
}
// =============================================================================
// APPFLOWY SIDEBAR ITEM WIDGET
// =============================================================================

/// AppFlowy-style sidebar item widget with config-based styling
class SidebarItemWidget extends HookWidget {
  const SidebarItemWidget({
    required this.label,
    required this.icon,
    required this.config,
    required this.isItemSelected,
    this.onTap,
    super.key,
    this.isDisabled = false,
    this.showFocusRing = true,
    this.autofocus = false,
  });

  /// The text label for the sidebar item
  final String label;

  /// The icon widget to display
  final Widget icon;

  /// Configuration for styling and layout
  final SidebarItemWidgetConfig config;

  /// Callback when the item is tapped
  final VoidCallback? onTap;

  /// Whether this item is currently selected
  final bool isItemSelected;

  /// Whether this item is disabled
  final bool isDisabled;

  /// Whether to show focus ring when focused
  final bool showFocusRing;

  /// Whether this item should autofocus
  final bool autofocus;

  @override
  Widget build(BuildContext context) {
    final focusNode = useFocusNode();
    final isHovering = useState(false);
    final isFocused = useState(false);
    final isSelected = useState<bool>(isItemSelected);

    useEffect(() {
      isSelected.value = isItemSelected;
      return null;
    }, [
      isItemSelected,
    ]);

    
    return Actions(
      actions: {
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (_) {
            if (!isDisabled && onTap != null) {
              onTap!();
            }
            return null;
          },
        ),
      },
      child: Focus(
        focusNode: focusNode,
        onFocusChange: (focused) => isFocused.value = focused,
        autofocus: autofocus,
        child: MouseRegion(
          cursor: _getCursor(),
          onEnter: (_) => isHovering.value = true,
          onExit: (_) => isHovering.value = false,
          child: GestureDetector(
            onTap: isDisabled ? null : onTap,
            child: AnimatedContainer(
              duration: config.animationDuration,
              curve: config.animationCurve,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(config.borderRadius),
                border: isFocused.value && showFocusRing
                    ? Border.all(
                        color: config.focusRingColor,
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      )
                    : null,
              ),
              child: AnimatedContainer(
                duration: config.animationDuration,
                curve: config.animationCurve,
                decoration: BoxDecoration(
                  color: _getBackgroundColor(
                    isHovering.value,
                    isFocused.value,
                    isSelected.value,
                  ),
                  border: Border.all(
                    color: _getBorderColor(
                      isHovering.value,
                      isFocused.value,
                      isSelected.value,
                    ),
                  ),
                  borderRadius: BorderRadius.circular(config.borderRadius),
                ),
                child: Padding(
                  padding: config.padding,
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: config.animationDuration,
                        curve: config.animationCurve,
                        child: IconTheme(
                          data: IconThemeData(
                            color: _getTextColor(
                              isHovering.value,
                              isFocused.value,
                              isSelected.value,
                            ),
                            size: config.iconSize,
                          ),
                          child: icon,
                        ),
                      ),
                      SizedBox(width: config.spacing),
                      Expanded(
                        child: AnimatedDefaultTextStyle(
                          duration: config.animationDuration,
                          curve: config.animationCurve,
                          style: _getTextStyle(
                            isHovering.value,
                            isFocused.value,
                            isSelected.value,
                          ),
                          child: Text(
                            label,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SystemMouseCursor _getCursor() {
    if (onTap == null || isDisabled) {
      return SystemMouseCursors.basic;
    }
    return SystemMouseCursors.click;
  }

  Color _getBackgroundColor(bool hovering, bool focused, bool isSelected) {
    if (isDisabled) {
      return config.disabledBackgroundColor;
    }
    if (isSelected) {
      return config.selectedBackgroundColor;
    }
    if (hovering) {
      return config.hoverBackgroundColor;
    }
    return config.backgroundColor;
  }

  Color _getBorderColor(bool hovering, bool focused, bool isSelected) {
    if (isDisabled) {
      return config.disabledBorderColor;
    }
    if (isSelected) {
      return config.selectedBorderColor;
    }
    if (hovering) {
      return config.hoverBorderColor;
    }
    return config.borderColor;
  }

  Color _getTextColor(bool hovering, bool focused, bool isSelected) {
    if (isDisabled) {
      return config.disabledTextColor;
    }
    if (isSelected) {
      return config.selectedTextColor;
    }
    if (hovering) {
      return config.hoverTextColor;
    }
    return config.textColor;
  }

  TextStyle _getTextStyle(bool hovering, bool focused, bool isSelected) {
    if (isDisabled) {
      return config.textStyleDisabled;
    }
    if (isSelected) {
      return config.textStyleSelected;
    }
    if (hovering) {
      return config.textStyleHover;
    }
    return config.textStyleNormal;
  }
}
