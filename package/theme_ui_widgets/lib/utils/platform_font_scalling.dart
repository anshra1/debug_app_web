import 'package:flutter/material.dart' show BuildContext, MediaQuery;


class ResponsiveBreakpoints {
  static double scaleFont(double fontSize, [BuildContext? context]) {
    if (context == null) return fontSize; // Use base size if no context

    final mediaQuery = MediaQuery.maybeOf(context);
    if (mediaQuery == null) return fontSize; // Use base size if no MediaQuery

    double width = mediaQuery.size.width;
    double scaleFactor;

    // Industry standard breakpoints and scaling
    if (width <= 600) {
      scaleFactor = 1.0; // Base size for mobile
    } else if (width <= 1024) {
      scaleFactor = 1.125; // 12.5% larger for tablet
    } else {
      // Fluid scaling for desktop with max cap
      scaleFactor = 1.0 + ((width - 600) / 3000);
      scaleFactor = scaleFactor.clamp(1.0, 1.25); // Cap at 25% larger
    }

    return fontSize * scaleFactor;
  }
}