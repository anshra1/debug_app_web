import 'package:flutter/material.dart';

enum IconPosition { left, right, none }

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.onPressed,
    required this.text,
    this.toolTipText = '',
    this.icon,
    this.iconPosition = IconPosition.none,
    this.backgroundColor,
    this.foregroundColor = Colors.white,
    this.elevation = 0,
    this.borderRadius = 32.0,
    this.textStyle = const TextStyle(fontSize: 16, letterSpacing: .66),
    this.padding = EdgeInsets.zero,
    this.size,
    super.key,
  });

  final VoidCallback onPressed;
  final String text;
  final Widget? icon;
  final IconPosition iconPosition;
  final TextStyle textStyle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double elevation;
  final double borderRadius;
  final EdgeInsets padding;
  final String toolTipText;
  final Size? size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Tooltip(
      message: toolTipText,
      child: Padding(
        padding: padding,
        child: SizedBox(
          width: size != null ? size!.width : double.infinity,
          height: size != null ? size!.height : 36,
          child: ElevatedButton(
            onPressed: onPressed,
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                backgroundColor ?? theme.colorScheme.primary,
              ),
              foregroundColor: WidgetStateProperty.all(
                foregroundColor ?? theme.colorScheme.onPrimary,
              ),
              elevation: WidgetStateProperty.all(elevation),
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
                  const SizedBox(width: 8),
                ],

                //
                if (iconPosition != IconPosition.none) const SizedBox.shrink(),
                //
                Text(
                  text,
                  style: textStyle.copyWith(color: foregroundColor),
                ),
                //
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
