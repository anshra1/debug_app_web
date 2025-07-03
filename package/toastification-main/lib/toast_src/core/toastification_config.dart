import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

@visibleForTesting
const defaultAlignment = AlignmentDirectional.topEnd;

@visibleForTesting
const defaultItemAnimationDuration = Duration(milliseconds: 600);

@visibleForTesting
const defaultWidth = 400.0;

@visibleForTesting
const defaultClipBehavior = Clip.none;

typedef ToastificationMarginBuilder = EdgeInsetsGeometry Function(
  BuildContext context,
  AlignmentGeometry alignment,
);

/// you can use [ToastificationConfig] class to change default values of [Toastification]
///
/// when you are using [show] or [showCustom] methods,
/// if some of the parameters are not provided,
///
/// [Toastification] will use this class to get the default values.
///
/// to provide the [ToastificationConfig] to the widget tree you can use
/// the [ToastificationConfigProvider] widget.
///
class ToastificationConfig extends Equatable {
  const ToastificationConfig({
    this.alignment = defaultAlignment,
    this.itemWidth = defaultWidth,
    this.clipBehavior = defaultClipBehavior,
    this.animationDuration = defaultItemAnimationDuration,
    this.animationBuilder = defaultAnimationBuilderConfig,
    this.margin,
    this.marginBuilder = defaultMarginBuilder,
    this.applyMediaQueryViewInsets = true,
    this.maxToastLimit = 10,
    this.maxTitleLines = 2,
    this.maxDescriptionLines = 6,
    this.blockBackgroundInteraction = false,
  });

  final AlignmentGeometry alignment;
  final double itemWidth;

  /// The ClipBehavior of [AnimatedList], used as entry point for all [ToastificationItem]s' widgets under the hood. The default value is [Clip.none].
  final Clip clipBehavior;

  /// The duration of the animation for [ToastificationItem]s. The default value is 600 milliseconds.
  final Duration animationDuration;

  final ToastificationAnimationBuilder animationBuilder;

  /// Simple margin property for Toastification Overlay.
  /// If provided, this takes priority over [marginBuilder].
  /// Example: EdgeInsets.all(16) or EdgeInsets.fromLTRB(0, 16, 0, 110)
  final EdgeInsetsGeometry? margin;

  /// Builder method for creating margin for Toastification Overlay.
  /// This is used as fallback when [margin] property is not provided.
  final ToastificationMarginBuilder marginBuilder;

  /// The maximum number of toasts that can be displayed at the same time.
  /// If the number of toasts exceeds this limit, the oldest toast will be removed.
  /// The default value is 10.
  final int maxToastLimit;

  /// The maximum number of lines to display for the toast title.
  /// If the title exceeds this number of lines, it will be truncated with an ellipsis.
  /// The default value is 2.
  final int maxTitleLines;

  /// The maximum number of lines to display for the toast description.
  /// If the description exceeds this number of lines, it will be truncated with an ellipsis.
  /// The default value is 2.
  final int maxDescriptionLines;

  /// Whether to apply the viewInsets to the margin of the Toastification Overlay.
  /// Basically, this is used to move the Toastification Overlay up or down when the keyboard is shown.
  /// So Toast overlay will not be hidden by the keyboard when the keyboard is shown.
  ///
  /// If set to true, MediaQuery.of(context).viewInsets will be added to the result of the [marginBuilder] method.
  final bool applyMediaQueryViewInsets;

  /// Whether to block background interaction.
  /// If set to true, the background will not be interactive.
  /// The default value is false.
  final bool blockBackgroundInteraction;

  /// Resolves the margin for the toast overlay.
  /// If [margin] is provided, uses it directly.
  /// Otherwise, falls back to [marginBuilder].
  EdgeInsetsGeometry resolveMargin(BuildContext context, AlignmentGeometry alignment) {
    if (margin != null) {
      return margin!;
    }
    return marginBuilder(context, alignment);
  }

  // Copy with method for ToastificationConfig
  ToastificationConfig copyWith({
    AlignmentGeometry? alignment,
    double? itemWidth,
    Clip? clipBehavior,
    Duration? animationDuration,
    ToastificationAnimationBuilder? animationBuilder,
    EdgeInsetsGeometry? margin,
    ToastificationMarginBuilder? marginBuilder,
    int? maxToastLimit,
    bool? applyMediaQueryViewInsets,
    bool? blockBackgroundInteraction,
  }) {
    return ToastificationConfig(
      alignment: alignment ?? this.alignment,
      itemWidth: itemWidth ?? this.itemWidth,
      clipBehavior: clipBehavior ?? this.clipBehavior,
      animationDuration: animationDuration ?? this.animationDuration,
      animationBuilder: animationBuilder ?? this.animationBuilder,
      margin: margin ?? this.margin,
      marginBuilder: marginBuilder ?? this.marginBuilder,
      maxToastLimit: maxToastLimit ?? this.maxToastLimit,
      applyMediaQueryViewInsets:
          applyMediaQueryViewInsets ?? this.applyMediaQueryViewInsets,
      blockBackgroundInteraction:
          blockBackgroundInteraction ?? this.blockBackgroundInteraction,
    );
  }

  @override
  List<Object?> get props => [
        alignment,
        itemWidth,
        clipBehavior,
        animationDuration,
        margin,
        marginBuilder,
        maxToastLimit,
        maxTitleLines,
        maxDescriptionLines,
        applyMediaQueryViewInsets,
        blockBackgroundInteraction,
      ];
}

/// Default animation builder for [Toastification]
@visibleForTesting
Widget defaultAnimationBuilderConfig(
  BuildContext context,
  Animation<double> animation,
  Alignment alignment,
  Widget child,
) {
  return DefaultToastificationTransition(
    animation: animation,
    alignment: alignment,
    child: child,
  );
}

/// Default margin builder for [Toastification]
@visibleForTesting
EdgeInsetsGeometry defaultMarginBuilder(
  BuildContext context,
  AlignmentGeometry alignment,
) {
  final y = alignment.resolve(Directionality.of(context)).y;

  return switch (y) {
    <= -0.5 => const EdgeInsets.only(top: 12),
    >= 0.5 => const EdgeInsets.only(bottom: 12),
    _ => EdgeInsets.zero,
  };
}
