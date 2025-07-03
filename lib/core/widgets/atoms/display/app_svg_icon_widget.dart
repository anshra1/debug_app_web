import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:theme_ui_widgets/theme/app_theme.dart';

// =============================================================================
// CONFIG CLASS FOR STYLING
// =============================================================================

class AppSvgIconConfig {
  const AppSvgIconConfig({
    // Layout Properties
    required this.size,
    required this.padding,
    required this.borderRadius,

    // Colors - Normal State
    required this.iconColor,
    required this.backgroundColor,

    // Colors - Hover State
    required this.hoverIconColor,
    required this.hoverBackgroundColor,

    // Colors - Pressed State
    required this.pressedIconColor,
    required this.pressedBackgroundColor,

    // Colors - Disabled State
    required this.disabledIconColor,
    required this.disabledBackgroundColor,

    // Elevation Properties
    required this.elevation,
    required this.hoverElevation,
    required this.pressedElevation,

    // Animation Properties
    required this.animationDuration,
    required this.animationCurve,

    // Tooltip Properties
    required this.tooltipTextStyle,
    required this.tooltipBackgroundColor,
    required this.tooltipPadding,
  });

  /// Default config based on AppThemeData from context
  factory AppSvgIconConfig.defaultConfig(BuildContext context) {
    final theme = AppTheme.of(context);
    final icon = theme.iconColorScheme;
    final fill = theme.fillColorScheme;
    final surface = theme.surfaceColorScheme;
    final spacing = theme.spacing;
    final radius = theme.borderRadius;

    return AppSvgIconConfig(
      // Layout Properties
      size: 24,
      padding: EdgeInsets.all(spacing.s),
      borderRadius: radius.s,

      // Colors - Normal State
      iconColor: icon.primary,
      backgroundColor: fill.primary.withOpacity(0), // Transparent but semantic

      // Colors - Hover State
      hoverIconColor: icon.primary,
      hoverBackgroundColor: fill.primaryHover,

      // Colors - Pressed State
      pressedIconColor: icon.primary,
      pressedBackgroundColor: fill.content,

      // Colors - Disabled State
      disabledIconColor: icon.quaternary,
      disabledBackgroundColor: fill.quaternary.withOpacity(0.5),

      // Elevation Properties
      elevation: 0,
      hoverElevation: 2,
      pressedElevation: 1,

      // Animation Properties
      animationDuration: const Duration(milliseconds: 150),
      animationCurve: Curves.easeInOut,

      // Tooltip Properties
      tooltipTextStyle: theme.textStyle.bodyMedium.standard(context: context),
      tooltipBackgroundColor: theme.surfaceColorScheme.inverse,
      tooltipPadding: EdgeInsets.symmetric(
        horizontal: spacing.m,
        vertical: spacing.s,
      ),
    );
  }

  /// Folder icon config for theme selection and file browsing
  factory AppSvgIconConfig.folderIconConfig(BuildContext context) {
    final theme = AppTheme.of(context);
    final fill = theme.fillColorScheme;
    final spacing = theme.spacing;
    final radius = theme.borderRadius;

    return AppSvgIconConfig(
      // Layout Properties
      size: 24,
      padding: EdgeInsets.all(spacing.s),
      borderRadius: radius.s,

      // Colors - Normal State
      iconColor: const Color.fromARGB(255, 149, 167, 182),
      backgroundColor: fill.primary.withOpacity(0), // Transparent but semantic

      // Colors - Hover State
      hoverIconColor: theme.iconColorScheme.primary,
      hoverBackgroundColor: fill.primaryHover,

      // Colors - Pressed State
      pressedIconColor: theme.iconColorScheme.primary,
      pressedBackgroundColor: fill.content,

      // Colors - Disabled State
      disabledIconColor: theme.iconColorScheme.quaternary,
      disabledBackgroundColor: fill.quaternary.withOpacity(0.5),

      // Elevation Properties
      elevation: 0,
      hoverElevation: 2,
      pressedElevation: 1,

      // Animation Properties
      animationDuration: const Duration(milliseconds: 150),
      animationCurve: Curves.easeInOut,

      // Tooltip Properties
      tooltipTextStyle: theme.textStyle.titleMedium.standard(context: context),
      tooltipBackgroundColor: theme.surfaceColorScheme.inverse,
      tooltipPadding: EdgeInsets.symmetric(
        horizontal: spacing.xl,
        vertical: spacing.l,
      ),
    );
  }

  // ==========================================================================
  // LAYOUT PROPERTIES
  // ==========================================================================

  /// Size of the SVG icon (width and height)
  final double size;

  /// Padding around the icon inside its container
  final EdgeInsetsGeometry padding;

  /// Border radius for the icon container
  final double borderRadius;

  // ==========================================================================
  // COLORS - NORMAL STATE
  // ==========================================================================

  /// Color of the SVG icon in normal state
  final Color iconColor;

  /// Background color of the icon container in normal state
  final Color backgroundColor;

  // ==========================================================================
  // COLORS - HOVER STATE
  // ==========================================================================

  /// Color of the SVG icon when hovering (if onTap is provided)
  final Color hoverIconColor;

  /// Background color of the icon container when hovering
  final Color hoverBackgroundColor;

  // ==========================================================================
  // COLORS - PRESSED STATE
  // ==========================================================================

  /// Color of the SVG icon when pressed/tapped
  final Color pressedIconColor;

  /// Background color of the icon container when pressed
  final Color pressedBackgroundColor;

  // ==========================================================================
  // COLORS - DISABLED STATE
  // ==========================================================================

  /// Color of the SVG icon when disabled
  final Color disabledIconColor;

  /// Background color of the icon container when disabled
  final Color disabledBackgroundColor;

  // ==========================================================================
  // ELEVATION PROPERTIES
  // ==========================================================================

  /// Elevation of the icon container in normal state
  final double elevation;

  /// Elevation of the icon container when hovering
  final double hoverElevation;

  /// Elevation of the icon container when pressed
  final double pressedElevation;

  // ==========================================================================
  // ANIMATION PROPERTIES
  // ==========================================================================

  /// Duration for all state transition animations
  final Duration animationDuration;

  /// Animation curve for all state transitions
  final Curve animationCurve;

  // ==========================================================================
  // TOOLTIP PROPERTIES
  // ==========================================================================

  /// Text style for the tooltip text
  final TextStyle tooltipTextStyle;

  /// Background color for the tooltip
  final Color tooltipBackgroundColor;

  /// Padding inside the tooltip
  final EdgeInsetsGeometry tooltipPadding;

  /// Creates a copy of this config with the given fields replaced with new values
  AppSvgIconConfig copyWith({
    double? size,
    EdgeInsetsGeometry? padding,
    double? borderRadius,
    Color? iconColor,
    Color? backgroundColor,
    Color? hoverIconColor,
    Color? hoverBackgroundColor,
    Color? pressedIconColor,
    Color? pressedBackgroundColor,
    Color? disabledIconColor,
    Color? disabledBackgroundColor,
    double? elevation,
    double? hoverElevation,
    double? pressedElevation,
    Duration? animationDuration,
    Curve? animationCurve,
    TextStyle? tooltipTextStyle,
    Color? tooltipBackgroundColor,
    EdgeInsetsGeometry? tooltipPadding,
  }) {
    return AppSvgIconConfig(
      size: size ?? this.size,
      padding: padding ?? this.padding,
      borderRadius: borderRadius ?? this.borderRadius,
      iconColor: iconColor ?? this.iconColor,
      backgroundColor: backgroundColor ?? this.backgroundColor,
      hoverIconColor: hoverIconColor ?? this.hoverIconColor,
      hoverBackgroundColor: hoverBackgroundColor ?? this.hoverBackgroundColor,
      pressedIconColor: pressedIconColor ?? this.pressedIconColor,
      pressedBackgroundColor: pressedBackgroundColor ?? this.pressedBackgroundColor,
      disabledIconColor: disabledIconColor ?? this.disabledIconColor,
      disabledBackgroundColor: disabledBackgroundColor ?? this.disabledBackgroundColor,
      elevation: elevation ?? this.elevation,
      hoverElevation: hoverElevation ?? this.hoverElevation,
      pressedElevation: pressedElevation ?? this.pressedElevation,
      animationDuration: animationDuration ?? this.animationDuration,
      animationCurve: animationCurve ?? this.animationCurve,
      tooltipTextStyle: tooltipTextStyle ?? this.tooltipTextStyle,
      tooltipBackgroundColor: tooltipBackgroundColor ?? this.tooltipBackgroundColor,
      tooltipPadding: tooltipPadding ?? this.tooltipPadding,
    );
  }
}

// =============================================================================
// APP SVG ICON WIDGET
// =============================================================================

/// A reusable SVG icon widget with optional onTap functionality and config-based styling
///
/// Features:
/// - Configurable size, color, and padding through AppSvgIconConfig
/// - Optional onTap with hover/press states and smooth animations
/// - Consistent with the app's design system via AppTheme integration
/// - Support for accessibility (tooltip, semantics)
/// - Disabled state support
class AppSvgIcon extends StatefulWidget {
  const AppSvgIcon({
    required this.assetPath,
    required this.config,
    this.onTap,
    this.tooltip,
    this.semanticLabel,
    this.enabled = true,
    super.key,
  });

  /// Path to the SVG asset (e.g., Assets.icons.folder)
  final String assetPath;

  /// Configuration for styling and behavior
  final AppSvgIconConfig config;

  /// Optional callback when the icon is tapped
  final VoidCallback? onTap;

  /// Tooltip text shown on hover
  final String? tooltip;

  /// Semantic label for accessibility
  final String? semanticLabel;

  /// Whether the icon is enabled (affects color and interaction)
  final bool enabled;

  @override
  State<AppSvgIcon> createState() => _AppSvgIconState();
}

class _AppSvgIconState extends State<AppSvgIcon> {
  bool _isHovered = false;
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    Widget iconWidget = AnimatedContainer(
      duration: widget.config.animationDuration,
      curve: widget.config.animationCurve,
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(widget.config.borderRadius),
      ),
      child: Material(
        color: Colors.transparent,
        elevation: _getElevation(),
        borderRadius: BorderRadius.circular(widget.config.borderRadius),
        child: Padding(
          padding: widget.config.padding,
          child: SvgPicture.asset(
            widget.assetPath,
            width: widget.config.size,
            height: widget.config.size,
            colorFilter: ColorFilter.mode(
              _getIconColor(),
              BlendMode.srcIn,
            ),
            semanticsLabel: widget.semanticLabel,
          ),
        ),
      ),
    );

    // If onTap is provided, make it interactive
    if (widget.onTap != null && widget.enabled) {
      iconWidget = GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _isPressed = true),
        onTapUp: (_) => setState(() => _isPressed = false),
        onTapCancel: () => setState(() => _isPressed = false),
        child: MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          cursor: SystemMouseCursors.click,
          child: iconWidget,
        ),
      );
    }

    // Add tooltip if provided
    if (widget.tooltip != null && widget.tooltip!.isNotEmpty) {
      iconWidget = Tooltip(
        message: widget.tooltip,
        textStyle: widget.config.tooltipTextStyle,
        decoration: BoxDecoration(
          color: widget.config.tooltipBackgroundColor,
          borderRadius: BorderRadius.circular(widget.config.borderRadius),
        ),
        padding: widget.config.tooltipPadding,
        child: iconWidget,
      );
    }

    // Add semantics for accessibility
    return Semantics(
      button: widget.onTap != null,
      enabled: widget.enabled,
      label: widget.semanticLabel,
      child: iconWidget,
    );
  }

  /// Get the current icon color based on state
  Color _getIconColor() {
    if (!widget.enabled) {
      return widget.config.disabledIconColor;
    }
    if (_isPressed) {
      return widget.config.pressedIconColor;
    }
    if (_isHovered) {
      return widget.config.hoverIconColor;
    }
    return widget.config.iconColor;
  }

  /// Get the current background color based on state
  Color _getBackgroundColor() {
    if (!widget.enabled) {
      return widget.config.disabledBackgroundColor;
    }
    if (_isPressed) {
      return widget.config.pressedBackgroundColor;
    }
    if (_isHovered) {
      return widget.config.hoverBackgroundColor;
    }
    return widget.config.backgroundColor;
  }

  /// Get the current elevation based on state
  double _getElevation() {
    if (!widget.enabled) {
      return widget.config.elevation;
    }
    if (_isPressed) {
      return widget.config.pressedElevation;
    }
    if (_isHovered) {
      return widget.config.hoverElevation;
    }
    return widget.config.elevation;
  }
}
