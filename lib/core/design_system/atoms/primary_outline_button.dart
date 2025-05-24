import 'package:flutter/material.dart';

enum IconPosition { left, right, none }

class PrimaryOutlinedButton extends StatelessWidget {
  const PrimaryOutlinedButton({
    required this.onPressed,
    required this.text,
    this.toolTipText = '',
    this.icon,
    this.iconPosition = IconPosition.left,
    this.foregroundColor,
    this.borderColor,
    this.borderWidth = 1.0,
    this.borderRadius = 32.0,
    this.textStyle = const TextStyle(
      fontSize: 16,
      
      letterSpacing: 0.6,
    ),
    this.padding = EdgeInsets.zero,
    this.size,
    super.key,
  });

  final VoidCallback onPressed;
  final String text;
  final Widget? icon;
  final IconPosition iconPosition;
  final TextStyle textStyle;
  final Color? foregroundColor;
  final Color? borderColor;
  final double borderWidth;
  final double borderRadius;
  final EdgeInsets padding;
  final String toolTipText;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final effectiveForegroundColor = foregroundColor ?? theme.colorScheme.primary;
    final effectiveBorderColor = borderColor ?? theme.colorScheme.primary;

    return Tooltip(
      message: toolTipText,
      child: Padding(
        padding: padding,
        child: SizedBox(
          width: size?.width ?? double.infinity,
          height: size?.height ?? 36,
          child: OutlinedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              foregroundColor: WidgetStateProperty.all(effectiveForegroundColor),
              side: WidgetStateProperty.all(
                BorderSide(
                  color: effectiveBorderColor,
                  width: borderWidth,
                ),
              ),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              padding: WidgetStateProperty.all(EdgeInsets.zero),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (iconPosition == IconPosition.left) ...[
                  icon ?? const SizedBox.shrink(),
                  const SizedBox.shrink(),
                ],
                Text(
                  text,
                  style: textStyle.copyWith(
                    color: foregroundColor ?? effectiveForegroundColor,
                  ),
                ),
                if (iconPosition == IconPosition.right) ...[
                  const SizedBox(width: 8),
                  icon ?? const SizedBox.shrink(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
