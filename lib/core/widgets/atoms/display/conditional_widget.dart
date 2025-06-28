import 'package:flutter/material.dart';

class ConditionalWidget extends StatelessWidget {
  const ConditionalWidget({
    required this.condition,
    required this.widget,
    this.fallback,
    super.key,
  });

  final bool condition;

  final Widget widget;

  final Widget? fallback;

  @override
  Widget build(BuildContext context) {
    return condition ? widget : fallback ?? const SizedBox.shrink();
  }
}
