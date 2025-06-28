import 'package:debug_app_web/core/config/central_ui.dart';
import 'package:flutter/material.dart';

enum IconPosition { left, right, none }

class TextDisplayWithLabelConfig {
  const TextDisplayWithLabelConfig({
    required this.cardElevation,
    required this.cardBorderColor,
    required this.cardBackgroundColor,
    required this.cardBorderRadius,
    required this.labelTextStyle,
    required this.displayTextStyle,
    required this.iconPosition,
    required this.contentPadding,
    required this.iconSize,
    required this.iconColor,
    required this.iconPadding,
    required this.textAlign,
  });

  factory TextDisplayWithLabelConfig.defaultConfig() {
    return TextDisplayWithLabelConfig(
      cardElevation: 0,
      cardBorderColor: Colors.grey.shade700,
      cardBackgroundColor: Colors.grey.shade900,
      cardBorderRadius: 8,
      labelTextStyle: const TextStyle(
        fontSize: 14,
        color: UIConfig.topBarSecondaryTextColor,
      ),
      displayTextStyle: const TextStyle(
        fontSize: 18,
        color: UIConfig.topBarPrimaryTextColor,
        letterSpacing: 0.7,
      ),
      iconPosition: IconPosition.right,
      contentPadding: const EdgeInsets.symmetric(horizontal: 1),
      iconSize: 16,
      iconColor: Colors.white,
      iconPadding: const EdgeInsets.only(left: 55),
      textAlign: TextAlign.left,
    );
  }

  final double cardElevation;
  final Color cardBorderColor;
  final Color cardBackgroundColor;
  final double cardBorderRadius;

  final TextStyle labelTextStyle;
  final TextStyle displayTextStyle;
  final IconPosition iconPosition;

  final EdgeInsets contentPadding;
  final double iconSize;
  final Color iconColor;
  final EdgeInsets iconPadding;
  final TextAlign textAlign;
}

class TextDisplayWithLabel extends StatelessWidget {
  const TextDisplayWithLabel({
    required this.labelText,
    required this.config,
    required this.getText,
    this.iconData,
    super.key,
    this.tooltipText = '',
  });

  final String labelText;
  final IconData? iconData;
  final TextDisplayWithLabelConfig config;
  final String Function() getText;
  final String tooltipText;

  @override
  Widget build(BuildContext context) {
    final displayText = getText();

    return Material(
      elevation: config.cardElevation,
      color: config.cardBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(config.cardBorderRadius),
        side: BorderSide(color: config.cardBorderColor),
      ),
      child: Padding(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            if (labelText.isNotEmpty) Text(labelText, style: config.labelTextStyle),
            Tooltip(
              message: tooltipText,
              child: SizedBox(
                width: double.infinity,
                height: 48,
                child: Row(
                  children: [
                    if (config.iconPosition == IconPosition.left)
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
                    if (config.iconPosition == IconPosition.right)
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
    );
  }
}
