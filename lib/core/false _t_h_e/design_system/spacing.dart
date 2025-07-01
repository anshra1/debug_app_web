import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

abstract class Spacing {
  // Base spacing units (based on 4pt grid)
  static const double s2 = 2; // 2dp
  static const double s4 = 4; // 4dp
  static const double s8 = 8; // 8dp
  static const double s12 = 12; // 12dp
  static const double s16 = 16; // 16dp
  static const double s24 = 24; // 24dp
  static const double s32 = 32; // 32dp
  static const double xxl40 = 40; // 40dp
  static const double xxxl48 = 48; // 48dp

  // Component specific spacing
  static const double buttonSpacing = s12;
  static const double cardPadding = s16;
  static const double listItemSpacing = s8;
  static const double sectionSpacing = s32;
  static const double screenMargin = s16;

  // Layout spacing
  static const EdgeInsets screenPadding = EdgeInsets.all(screenMargin);
  static const EdgeInsets contentPadding = EdgeInsets.all(s16);
  static const EdgeInsets cardInnerPadding = EdgeInsets.all(cardPadding);

  // Gaps
  static const Gap gap2XXS = Gap(2);
  static const Gap gap4XS = Gap(s4);
  static const Gap gap8SM = Gap(s12);
  static const Gap gap16MD = Gap(s16);
  static const Gap gap24LG = Gap(s24);
  static const Gap gap32XL = Gap(s32);
  static const Gap gap48XXL = Gap(xxl40);
}
