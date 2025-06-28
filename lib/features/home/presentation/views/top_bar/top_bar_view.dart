import 'package:debug_app_web/core/config/central_ui.dart';
import 'package:debug_app_web/features/home/presentation/widget/circulat_button.dart'; // Corrected import for CircularButton
import 'package:debug_app_web/features/home/presentation/widget/server_button.dart'; // Corrected import for ServerButton
import 'package:debug_app_web/features/home/presentation/widget/server_details_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class TopBarView extends HookWidget {
  const TopBarView({
    required this.showSideBar,
    required this.stopServer,
    required this.startServer,
    required this.lightMode,
    required this.settings,
    required this.notifications,
    required this.isSideBarExpanded,
    required this.showSolution,
    required this.connectedClientCount,
    required this.serverData,
    required this.isDarkMode,
    super.key,
  });

  final ValueNotifier<int> connectedClientCount;
  final ValueNotifier<bool> serverData;
  final VoidCallback showSideBar;
  final bool isSideBarExpanded;
  final VoidCallback startServer;
  final VoidCallback lightMode;
  final VoidCallback settings;
  final VoidCallback notifications;
  final VoidCallback showSolution;
  final VoidCallback stopServer;
  final bool isDarkMode;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: UIConfig.middlePanelPadding),
      height: 85,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularButton(
            icon: isSideBarExpanded
                ? LucideIcons.panelLeftClose
                : LucideIcons.panelLeftOpen,
            onPressed: showSideBar,
          ),
          const Gap(12),
          CircularButton(
            icon: Icons.arrow_forward_ios_outlined,
            onPressed: showSolution,
          ),
          // CustomPopup test button

          const Spacer(),
          CircularButton(
            icon: isDarkMode ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            onPressed: lightMode,
          ),
          const Gap(12),
          CircularButton(
            icon: Icons.settings_outlined,
            onPressed: settings,
          ),
          const Gap(12),
          CircularButton(
            icon: Icons.notifications_outlined,
            onPressed: notifications,
          ),
          const Gap(12),
          const ServerDetailsIconWidget(),
          const Gap(12),
          ServerButton(
            startServer: startServer,
            stopServer: stopServer,
            isServerRunning: serverData,
            connectedClientCount: connectedClientCount,
          ),
        ],
      ),
    );
  }
}
