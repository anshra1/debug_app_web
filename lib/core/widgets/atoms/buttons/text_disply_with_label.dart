import 'package:flutter/material.dart';
import 'package:theme_ui_widgets/app_theme.dart';

enum IconPosition { left, right, none }

// =============================================================================
// CONFIG CLASS FOR STYLING
// =============================================================================

class TextDisplayWithLabelConfig {
  const TextDisplayWithLabelConfig({
    // Card Properties
    required this.cardElevation,
    required this.cardBorderColor,
    required this.cardBackgroundColor,
    required this.cardBorderRadius,
    required this.cardPadding,

    // Label Properties
    required this.labelTextStyle,
    required this.labelSpacing,

    // Display Properties
    required this.displayTextStyle,
    required this.contentPadding,
    required this.textAlign,
    required this.displayHeight,

    // Icon Properties
    required this.iconPosition,
    required this.iconSize,
    required this.iconColor,
    required this.iconPadding,

    // Animation Properties
    required this.animationDuration,
  });

  /// Default config based on AppThemeData from context
  factory TextDisplayWithLabelConfig.defaultConfig(BuildContext context) {
    final theme = AppTheme.of(context);
    final text = theme.textColorScheme;
    final border = theme.borderColorScheme;
    final surface = theme.surfaceColorScheme;
    final spacing = theme.spacing;
    final radius = theme.borderRadius;

    return TextDisplayWithLabelConfig(
      // Card Properties
      cardElevation: 0,
      cardBorderColor: border.primary,
      cardBackgroundColor: surface.layer02,
      cardBorderRadius: radius.m,
      cardPadding: EdgeInsets.all(spacing.l),

      // Label Properties
      labelTextStyle: theme.textStyle.labelLarge.standard(
        context: context,
        color: text.secondary,
      ),
      labelSpacing: spacing.s,

      // Display Properties
      displayTextStyle: theme.textStyle.bodyLarge.standard(
        context: context,
        color: text.primary,
      ),
      contentPadding: EdgeInsets.symmetric(
        horizontal: spacing.l,
        vertical: spacing.m,
      ),
      textAlign: TextAlign.left,
      displayHeight: 48,

      // Icon Properties
      iconPosition: IconPosition.right,
      iconSize: 20,
      iconColor: text.primary,
      iconPadding: EdgeInsets.only(right: spacing.m),

      // Animation Properties
      animationDuration: const Duration(milliseconds: 200),
    );
  }

  // Card Properties
  /// Elevation of the card container
  final double cardElevation;

  /// Border color of the card container
  final Color cardBorderColor;

  /// Background color of the card container
  final Color cardBackgroundColor;

  /// Border radius of the card container
  final double cardBorderRadius;

  /// Padding inside the card container
  final EdgeInsetsGeometry cardPadding;

  // Label Properties
  /// Text style for the label above the display text
  final TextStyle labelTextStyle;

  /// Spacing between label and display content
  final double labelSpacing;

  // Display Properties
  /// Text style for the displayed content
  final TextStyle displayTextStyle;

  /// Padding around the display content
  final EdgeInsets contentPadding;

  /// Text alignment for the displayed content
  final TextAlign textAlign;

  /// Height of the display content area
  final double displayHeight;

  // Icon Properties
  /// Position of the icon relative to the text
  final IconPosition iconPosition;

  /// Size of the icon
  final double iconSize;

  /// Color of the icon
  final Color iconColor;

  /// Padding around the icon
  final EdgeInsets iconPadding;

  // Animation Properties
  /// Duration for state transition animations
  final Duration animationDuration;
}

// =============================================================================
// TEXT DISPLAY WITH LABEL WIDGET
// =============================================================================

/// A widget that displays read-only text with a label and optional icon
class TextDisplayWithLabel extends StatelessWidget {
  const TextDisplayWithLabel({
    required this.labelText,
    required this.config,
    required this.getText,
    this.iconData,
    this.tooltipText = '',
    super.key,
  });

  /// The text label displayed above the content
  final String labelText;

  /// The icon to display (optional)
  final IconData? iconData;

  /// Configuration for styling and layout
  final TextDisplayWithLabelConfig config;

  /// Function that returns the text to display
  final String Function() getText;

  /// Tooltip text shown on hover
  final String tooltipText;

  @override
  Widget build(BuildContext context) {
    final displayText = getText();

    return AnimatedContainer(
      duration: config.animationDuration,
      child: Material(
        elevation: config.cardElevation,
        color: config.cardBackgroundColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(config.cardBorderRadius),
          side: BorderSide(color: config.cardBorderColor),
        ),
        child: Padding(
          padding: config.cardPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              if (labelText.isNotEmpty) ...[
                Text(labelText, style: config.labelTextStyle),
                SizedBox(height: config.labelSpacing),
              ],
              Tooltip(
                message: tooltipText,
                child: SizedBox(
                  width: double.infinity,
                  height: config.displayHeight,
                  child: Row(
                    children: [
                      if (config.iconPosition == IconPosition.left && iconData != null)
                        Padding(
                          padding: config.iconPadding,
                          child: Icon(
                            iconData,
                            size: config.iconSize,
                            color: config.iconColor,
                          ),
                        ),
                      Expanded(
                        child: Padding(
                          padding: config.contentPadding,
                          child: Text(
                            displayText,
                            textAlign: config.textAlign,
                            style: config.displayTextStyle,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      if (config.iconPosition == IconPosition.right && iconData != null)
                        Padding(
                          padding: config.iconPadding,
                          child: Icon(
                            iconData,
                            size: config.iconSize,
                            color: config.iconColor,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
