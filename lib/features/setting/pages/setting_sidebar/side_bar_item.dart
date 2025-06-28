import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// =============================================================================
// CONFIG CLASS FOR STYLING
// =============================================================================

class AppSidebarItemConfig {
  const AppSidebarItemConfig({
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

    // Colors - Focus
    required this.focusRingColor,

    // Typography
    required this.textStyle,

    // Animation
    required this.animationDuration,
    required this.animationCurve,
  });

  /// Default config based on theme brightness
  factory AppSidebarItemConfig.defaultConfig(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    return AppSidebarItemConfig(
      // Layout
      padding: const EdgeInsets.all(12),
      borderRadius: 8,
      spacing: 12,
      iconSize: 20,

      // Colors - Normal State
      backgroundColor: Colors.transparent,
      borderColor: Colors.transparent,
      textColor: isDark ? const Color(0xFFF9FAFB) : const Color(0xFF1F2937),

      // Colors - Hover State
      hoverBackgroundColor: isDark ? const Color(0xFF374151) : const Color(0xFFF3F4F6),
      hoverBorderColor: Colors.transparent,
      hoverTextColor: isDark ? const Color(0xFFF9FAFB) : const Color(0xFF1F2937),

      // Colors - Selected State
      selectedBackgroundColor: isDark ? const Color(0xFF1E3A8A) : const Color(0xFFEBF8FF),
      selectedBorderColor: Colors.transparent,
      selectedTextColor: isDark ? const Color(0xFFBFDBFE) : const Color(0xFF1E40AF),

      // Colors - Disabled State
      disabledBackgroundColor: Colors.transparent,
      disabledBorderColor: Colors.transparent,
      disabledTextColor: isDark ? const Color(0xFF6B7280) : const Color(0xFF9CA3AF),

      // Colors - Focus
      focusRingColor: isDark ? const Color(0xFF60A5FA) : const Color(0xFF3B82F6),

      // Typography
      textStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        height: 1.2,
      ),

      // Animation
      animationDuration: const Duration(milliseconds: 200),
      animationCurve: Curves.easeInOut,
    );
  }

  // Layout properties
  /// Internal padding around the sidebar item content (icon + text)
  final EdgeInsetsGeometry padding;

  /// Corner radius for the sidebar item background container
  final double borderRadius;

  /// Space between the icon and text label
  final double spacing;

  /// Size of the icon displayed in the sidebar item
  final double iconSize;

  // Normal state colors (default appearance)
  /// Background color when sidebar item is in normal/idle state
  final Color backgroundColor;

  /// Border color when sidebar item is in normal/idle state
  final Color borderColor;

  /// Text and icon color when sidebar item is in normal/idle state
  final Color textColor;

  // Hover state colors (mouse over)
  /// Background color when user hovers over the sidebar item
  final Color hoverBackgroundColor;

  /// Border color when user hovers over the sidebar item
  final Color hoverBorderColor;

  /// Text and icon color when user hovers over the sidebar item
  final Color hoverTextColor;

  // Selected state colors (active/current item)
  /// Background color when sidebar item is currently selected/active
  final Color selectedBackgroundColor;

  /// Border color when sidebar item is currently selected/active
  final Color selectedBorderColor;

  /// Text and icon color when sidebar item is currently selected/active
  final Color selectedTextColor;

  // Disabled state colors (non-interactive)
  /// Background color when sidebar item is disabled/non-clickable
  final Color disabledBackgroundColor;

  /// Border color when sidebar item is disabled/non-clickable
  final Color disabledBorderColor;

  /// Text and icon color when sidebar item is disabled/non-clickable
  final Color disabledTextColor;

  // Focus colors (keyboard navigation)
  /// Color of the focus ring that appears when item is focused via keyboard
  final Color focusRingColor;

  // Typography
  /// Text style for the sidebar item label (font size, weight, etc.)
  final TextStyle textStyle;

  // Animation
  /// Duration for color/state transition animations (hover, select, etc.)
  final Duration animationDuration;

  /// Animation curve for smooth transitions between states
  final Curve animationCurve;
}

// =============================================================================
// APPFLOWY SIDEBAR ITEM WIDGET
// =============================================================================

/// AppFlowy-style sidebar item widget with config-based styling
class SidebarItem extends StatefulWidget {
  const SidebarItem({
    required this.label,
    required this.icon,
    required this.config,
    this.onTap,
    super.key,
    this.isSelected = false,
    this.isDisabled = false,
    this.showFocusRing = true,
    this.autofocus = false,
  });

  /// The text label for the sidebar item
  final String label;

  /// The icon widget to display
  final Widget icon;

  /// Configuration for styling and layout
  final AppSidebarItemConfig config;

  /// Callback when the item is tapped
  final VoidCallback? onTap;

  /// Whether this item is currently selected
  final bool isSelected;

  /// Whether this item is disabled
  final bool isDisabled;

  /// Whether to show focus ring when focused
  final bool showFocusRing;

  /// Whether this item should autofocus
  final bool autofocus;

  @override
  State<SidebarItem> createState() => _SidebarItemState();
}

class _SidebarItemState extends State<SidebarItem> {
  final FocusNode _focusNode = FocusNode();
  bool _isHovering = false;
  bool _isFocused = false;

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Actions(
      actions: {
        ActivateIntent: CallbackAction<ActivateIntent>(
          onInvoke: (_) {
            if (!widget.isDisabled && widget.onTap != null) {
              widget.onTap!();
            }
            return null;
          },
        ),
      },
      child: Focus(
        focusNode: _focusNode,
        onFocusChange: (isFocused) {
          setState(() => _isFocused = isFocused);
        },
        autofocus: widget.autofocus,
        child: MouseRegion(
          cursor: _getCursor(),
          onEnter: (_) => setState(() => _isHovering = true),
          onExit: (_) => setState(() => _isHovering = false),
          child: GestureDetector(
            onTap: widget.isDisabled ? null : widget.onTap,
            child: AnimatedContainer(
              duration: widget.config.animationDuration,
              curve: widget.config.animationCurve,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.config.borderRadius),
                border: _isFocused && widget.showFocusRing
                    ? Border.all(
                        color: widget.config.focusRingColor,
                        width: 2,
                        strokeAlign: BorderSide.strokeAlignOutside,
                      )
                    : null,
              ),
              child: AnimatedContainer(
                duration: widget.config.animationDuration,
                curve: widget.config.animationCurve,
                decoration: BoxDecoration(
                  color: _getBackgroundColor(),
                  border: Border.all(color: _getBorderColor()),
                  borderRadius: BorderRadius.circular(widget.config.borderRadius),
                ),
                child: Padding(
                  padding: widget.config.padding,
                  child: Row(
                    children: [
                      AnimatedContainer(
                        duration: widget.config.animationDuration,
                        curve: widget.config.animationCurve,
                        child: IconTheme(
                          data: IconThemeData(
                            color: _getTextColor(),
                            size: widget.config.iconSize,
                          ),
                          child: widget.icon,
                        ),
                      ),
                      SizedBox(width: widget.config.spacing),
                      Expanded(
                        child: AnimatedDefaultTextStyle(
                          duration: widget.config.animationDuration,
                          curve: widget.config.animationCurve,
                          style: widget.config.textStyle.copyWith(
                            color: _getTextColor(),
                          ),
                          child: Text(
                            widget.label,
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
    if (widget.onTap == null || widget.isDisabled) {
      return SystemMouseCursors.basic;
    }
    return SystemMouseCursors.click;
  }

  Color _getBackgroundColor() {
    if (widget.isDisabled) {
      return widget.config.disabledBackgroundColor;
    }
    if (widget.isSelected) {
      return widget.config.selectedBackgroundColor;
    }
    if (_isHovering) {
      return widget.config.hoverBackgroundColor;
    }
    return widget.config.backgroundColor;
  }

  Color _getBorderColor() {
    if (widget.isDisabled) {
      return widget.config.disabledBorderColor;
    }
    if (widget.isSelected) {
      return widget.config.selectedBorderColor;
    }
    if (_isHovering) {
      return widget.config.hoverBorderColor;
    }
    return widget.config.borderColor;
  }

  Color _getTextColor() {
    if (widget.isDisabled) {
      return widget.config.disabledTextColor;
    }
    if (widget.isSelected) {
      return widget.config.selectedTextColor;
    }
    if (_isHovering) {
      return widget.config.hoverTextColor;
    }
    return widget.config.textColor;
  }
}
