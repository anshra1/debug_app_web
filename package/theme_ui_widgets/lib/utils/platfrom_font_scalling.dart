import 'package:flutter/material.dart';

class ResponsiveFontScaling {
  // Standard breakpoints used in industry
  static const double _mobileBreakpoint = 600;
  static const double _tabletBreakpoint = 1024;

  /// Get the appropriate scale factor based on screen width
  static double getScaleFactor(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    
    // Industry standard scaling factors
    if (screenWidth <= _mobileBreakpoint) {
      return 1.0;  // Base size for mobile
    } else if (screenWidth <= _tabletBreakpoint) {
      return 1.125;  // 12.5% larger for tablet
    } else {
      // For larger screens, use a capped fluid scaling
      // Common industry practice: cap at 1.25 (25% larger)
      double scale = 1.0 + ((screenWidth - _mobileBreakpoint) / 3000);
      return scale.clamp(1.0, 1.25);
    }
  }

  /// Scale a font size based on the screen width
  static double scaleFontSize(BuildContext context, double baseFontSize) {
    return baseFontSize * getScaleFactor(context);
  }

  /// Get text style with responsive font size
  static TextStyle getResponsiveTextStyle(
    BuildContext context,
    TextStyle baseStyle,
  ) {
    return baseStyle.copyWith(
      fontSize: scaleFontSize(context, baseStyle.fontSize ?? 14),
    );
  }
}