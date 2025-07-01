import 'package:flutter/material.dart';

class SettingSidebarViewWidget extends StatelessWidget {
  const SettingSidebarViewWidget({
    required this.widget,
    super.key,
    this.width = 280.0,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(16),
  });

  final Widget widget;
  final double width;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = Theme.of(context).scaffoldBackgroundColor;

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        border: Border(
          right: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Padding(
        padding: padding,
        child: widget,
      ),
    );
  }
}
