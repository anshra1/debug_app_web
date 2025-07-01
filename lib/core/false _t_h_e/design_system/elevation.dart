import 'package:flutter/material.dart';

/// Design tokens for elevation and shadow styles
abstract class ElevationTokens {
  // Elevation levels
  static const double level0 = 0;
  static const double level1 = 1;
  static const double level2 = 2;
  static const double level3 = 4;
  static const double level4 = 6;
  static const double level5 = 8;

  // Shadow styles
  static List<BoxShadow> shadow1(BuildContext context) => [
        BoxShadow(
          color: Theme.of(context).shadowColor,
          blurRadius: 3,
          offset: const Offset(0, 1),
        ),
      ];

  static List<BoxShadow> shadow2(BuildContext context) => [
        BoxShadow(
          color: Theme.of(context).shadowColor,
          blurRadius: 6,
          offset: const Offset(0, 2),
        ),
      ];

  static List<BoxShadow> shadow3(BuildContext context) => [
        BoxShadow(
          color: Theme.of(context).shadowColor,
          blurRadius: 8,
          offset: const Offset(0, 4),
        ),
      ];

  static List<BoxShadow> shadow4(BuildContext context) => [
        BoxShadow(
          color: Theme.of(context).shadowColor,
          blurRadius: 12,
          offset: const Offset(0, 6),
        ),
      ];

  static List<BoxShadow> shadow5(BuildContext context) => [
        BoxShadow(
          color: Theme.of(context).shadowColor,
          blurRadius: 16,
          offset: const Offset(0, 8),
        ),
      ];
}
