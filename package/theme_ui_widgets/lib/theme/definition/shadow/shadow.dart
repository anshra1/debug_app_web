import 'package:flutter/widgets.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:ui' show Color, lerpDouble;

part 'shadow.freezed.dart';
part 'shadow.g.dart';

@freezed

class AppShadow with _$AppShadow {
  const factory AppShadow({
    required List<AppBoxShadow> small,
    required List<AppBoxShadow> medium,
  }) = _AppShadow;

  factory AppShadow.fromJson(Map<String, dynamic> json) => _$AppShadowFromJson(json);
}

@freezed
class AppBoxShadow with _$AppBoxShadow {
  const factory AppBoxShadow({
    required double offsetX,
    required double offsetY,
    required double blurRadius,
    required double spreadRadius,
    required String color,
  }) = _AppBoxShadow;

  factory AppBoxShadow.fromJson(Map<String, dynamic> json) =>
      _$AppBoxShadowFromJson(json);
}


// Extension for shadow conversion utilities
extension AppShadowUtils on AppShadow {
  /// Convert AppBoxShadow to BoxShadow
  BoxShadow appBoxShadowToBoxShadow(AppBoxShadow appShadow) {
    return BoxShadow(
      offset: Offset(appShadow.offsetX, appShadow.offsetY),
      blurRadius: appShadow.blurRadius,
      spreadRadius: appShadow.spreadRadius,
      color: _hexToColor(appShadow.color),
    );
  }

  /// Convert BoxShadow to AppBoxShadow
  AppBoxShadow boxShadowToAppBoxShadow(BoxShadow boxShadow) {
    return AppBoxShadow(
      offsetX: boxShadow.offset.dx,
      offsetY: boxShadow.offset.dy,
      blurRadius: boxShadow.blurRadius,
      spreadRadius: boxShadow.spreadRadius,
      color: _colorToHex(boxShadow.color),
    );
  }

  /// Get small shadows as BoxShadow list
  List<BoxShadow> get smallBoxShadows => small.map(appBoxShadowToBoxShadow).toList();

  /// Get medium shadows as BoxShadow list
  List<BoxShadow> get mediumBoxShadows => medium.map(appBoxShadowToBoxShadow).toList();

   Color _hexToColor(String hex) {
    final cleanHex = hex.replaceAll('#', '');
    final colorHex = cleanHex.length == 6 ? 'FF$cleanHex' : cleanHex;
    return Color(int.parse(colorHex, radix: 16));
  }

    String _colorToHex(Color color) {
    return '#${(((color.a * 255).round() << 24) | ((color.r * 255).round() << 16) | ((color.g * 255).round() << 8) | (color.b * 255).round()).toRadixString(16).padLeft(8, '0').substring(2)}';
  }
}



extension AppBoxShadowLerp on AppBoxShadow {
  AppBoxShadow lerpWith(AppBoxShadow other, double t) {
    return AppBoxShadow(
      offsetX: lerpDouble(offsetX, other.offsetX, t)!,
      offsetY: lerpDouble(offsetY, other.offsetY, t)!,
      blurRadius: lerpDouble(blurRadius, other.blurRadius, t)!,
      spreadRadius: lerpDouble(spreadRadius, other.spreadRadius, t)!,
      color: _lerpColorHex(color, other.color, t),
    );
  }

  /// Helper: Interpolates between two hex colors.
  String _lerpColorHex(String hexA, String hexB, double t) {
    final a = _colorFromHex(hexA);
    final b = _colorFromHex(hexB);
    final c = Color.lerp(a, b, t)!;
    return '#${c.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }

  Color _colorFromHex(String hex) {
    final cleanedHex = hex.replaceAll('#', '');
    final hasAlpha = cleanedHex.length == 8;
    return Color(int.parse(
      hasAlpha ? cleanedHex : 'FF$cleanedHex',
      radix: 16,
    ),);
  }
}


extension AppShadowLerp on AppShadow {
  AppShadow lerpWith(AppShadow other, double t) {
    return AppShadow(
      small: _lerpShadowList(small, other.small, t),
      medium: _lerpShadowList(medium, other.medium, t),
    );
  }

  List<AppBoxShadow> _lerpShadowList(
    List<AppBoxShadow> a,
    List<AppBoxShadow> b,
    double t,
  ) {
    final maxLength = a.length > b.length ? a.length : b.length;
    return List.generate(maxLength, (i) {
      final aShadow = i < a.length ? a[i] : a.last;
      final bShadow = i < b.length ? b[i] : b.last;
      return aShadow.lerpWith(bShadow, t);
    });
  }
}
