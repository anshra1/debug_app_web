import 'package:dart_style/dart_style.dart';
import 'package:example/src/features/home/views/ui_states/animation_type.dart';
import 'package:example/src/features/home/views/ui_states/toast_detail_ui_state.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class ToastCodeFormatter {
  static final _formatter = DartFormatter(
    languageVersion: DartFormatter.latestLanguageVersion,
    lineEnding: '\n\t',
  );

  static String format(ToastDetail toastDetail) {
    final StringBuffer code = StringBuffer();

    code.writeln('toastification.show(');

    if (toastDetail.useContext) {
      code.writeln('context: context,');
    }

    code.writeln('type: ${toastDetail.type},');
    code.writeln('style: ${toastDetail.style},');

    if (toastDetail.title != null) {
      code.writeln('\ttitle: Text("${(toastDetail.title as Text).data}"),');
    }

    if (toastDetail.description != null) {
      code.writeln(
          '\tdescription: Text("${(toastDetail.description as Text).data}"),');
    }

    code.writeln('\talignment: ${toastDetail.alignment},');

    if (toastDetail.autoCloseDuration != null &&
        toastDetail.autoCloseDuration!.inMilliseconds >= 500) {
      final duration = toastDetail.autoCloseDuration;

      final seconds = duration!.inSeconds;

      final milliseconds = seconds > 0
          ? duration.inMilliseconds - (seconds * 1000)
          : duration.inMilliseconds;

      code.write('\tautoCloseDuration: const Duration(');

      if (milliseconds > 0) {
        code.write('seconds: $seconds,');
        code.write('milliseconds: $milliseconds,');
      } else {
        code.write('seconds: $seconds');
      }

      code.writeln('),');
    }

    if (toastDetail.animationType != const BounceAnimationType()) {
      code.writeln(
          '\tanimationBuilder: ${toastDetail.animationType.buildCode()},');
    }

    if (toastDetail.primaryColor != null) {
      code.writeln(
          '\tprimaryColor: Color(0x${toastDetail.primaryColor!.hexAlpha}),');
    }

    if (toastDetail.backgroundColor != null) {
      code.writeln(
          '\tbackgroundColor: Color(0x${toastDetail.backgroundColor!.hexAlpha}),');
    }

    if (toastDetail.foregroundColor != null) {
      code.writeln(
          '\tforegroundColor: Color(0x${toastDetail.foregroundColor!.hexAlpha}),');
    }

    if (toastDetail.iconColor != null) {
      code.writeln('\ticonColor: ${toastDetail.iconColor},');
    }

    if (toastDetail.icon != null) {
      code.writeln('\ticon: Icon(Iconsax.${toastDetail.icon?.name}),');
    }

    if (toastDetail.borderRadius != null) {
      code.writeln('\tborderRadius: ${toastDetail.borderRadius},');
    }

    if (toastDetail.shadow != ShadowOptions.none) {
      code.writeln('\tboxShadow: ${toastDetail.shadow.name},');
    }

    if (toastDetail.showProgressBar == true) {
      code.writeln('\tshowProgressBar: ${toastDetail.showProgressBar},');
    }

    if (toastDetail.direction == TextDirection.rtl) {
      code.writeln('\tdirection: ${toastDetail.direction},');
    }

    if (toastDetail.closeButton.showType != CloseButtonShowType.always) {
      code.writeln(
        '\tcloseButton: ToastCloseButton(showType: ${toastDetail.closeButton.showType.toValueString()}),',
      );
    }

    if (toastDetail.closeOnClick == false) {
      code.writeln('\tcloseOnClick: ${toastDetail.closeOnClick},');
    }
    if (toastDetail.dragToClose == true) {
      code.writeln('\tdragToClose: ${toastDetail.dragToClose},');
    }

    if (toastDetail.pauseOnHover == false) {
      code.writeln('\tpauseOnHover: ${toastDetail.pauseOnHover},');
    }

    if (toastDetail.applyBlurEffect == true) {
      code.writeln('\tapplyBlurEffect: ${toastDetail.applyBlurEffect},');
    }
    if (toastDetail.showIcon == false) {
      code.writeln('\tshowIcon: ${toastDetail.showIcon},');
    }

    code.write(');');

    return _formatter.formatStatement(code.toString());
  }
}
