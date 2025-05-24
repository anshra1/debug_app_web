import 'package:baby_package/baby_package.dart';
import 'package:debug_app_web/core/design_system/atoms/primary_button.dart';
import 'package:debug_app_web/core/design_system/atoms/primary_outline_button.dart';
import 'package:debug_app_web/core/theme/theme_switcher_widget.dart';
import 'package:debug_app_web/features/server/web_error_manager.dart';
import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({
    required this.showSideBarOnPressed,
    required this.totalErrors,
    required this.startServerOnPressed,
    required this.stopServerOnPressed,
    super.key,
  });

  final VoidCallback showSideBarOnPressed;
  final int totalErrors;
  final VoidCallback startServerOnPressed;
  final VoidCallback stopServerOnPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      width: double.infinity,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              PrimaryOutlinedButton(
                onPressed: showSideBarOnPressed,
                text: 'Show Side Bar',
                size: const Size(180, 40),
                foregroundColor: Colors.white,
                borderColor: Colors.white,
                borderWidth: 2,
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Container(
                  height: 40,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Center(
                    child: AppText.titleLarge(
                      'Total Errors: $totalErrors',
                      letterSpacing: .6,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                IconButton(
                  icon: const Icon(Icons.settings),
                  onPressed: () {
                    try {
                      throw Exception('Test error for demonstration');
                    } on Exception catch (e) {
                      WebErrorManager.platform.sendError(
                        error: e,
                        stackTrace: StackTrace.fromString('s.readable'),
                      );
                    }
                  },
                  tooltip: 'Settings',
                  color: Colors.white,
                ),
                const SizedBox(width: 10),
                const ThemeSwitch(),
                const SizedBox(width: 10),
                PrimaryButton(
                  onPressed: startServerOnPressed,
                  text: 'Start Server',
                  toolTipText: 'Start Server',
                  size: const Size(180, 40),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
