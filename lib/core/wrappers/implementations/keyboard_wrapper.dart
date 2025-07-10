import 'package:debug_app_web/core/wrappers/base/app_wrapper.dart';
import 'package:flutter/material.dart';

/// Wrapper that handles keyboard dismissal behavior
class KeyboardDismissWrapper implements AppWrapper {
  const KeyboardDismissWrapper();

  @override
  Widget wrap(BuildContext context, Widget child) {
    return GestureDetector(
      onTap: () {
        final currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: child,
    );
  }

  @override
  int get priority => 2; // Runs after system UI setup
}
