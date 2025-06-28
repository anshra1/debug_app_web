import 'package:debug_app_web/core/config/central_ui.dart'; // Importing UIConfig
import 'package:flutter/material.dart';

class CircularButton extends StatelessWidget {
  const CircularButton({
    required this.icon,
    this.onPressed,
    this.size = 28,
    Color? backgroundColor,
    this.iconColor = UIConfig.topBarIconColor,
    super.key,
  }) : backgroundColor = backgroundColor ?? Colors.transparent;

  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final Color backgroundColor;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          size: size,
          color: iconColor,
        ),
      ),
    );
  }
}
