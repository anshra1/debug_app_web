import 'package:debug_app_web/core/config/central_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';

class ServerButton extends HookWidget {
  const ServerButton({
    required this.startServer,
    required this.stopServer,
    required this.isServerRunning,
    required this.connectedClientCount,
    super.key,
  });

  final VoidCallback startServer;
  final VoidCallback stopServer;
  final ValueNotifier<bool> isServerRunning;
  final ValueNotifier<int> connectedClientCount;

  @override
  Widget build(BuildContext context) {
    final isServerRunning = useValueListenable(this.isServerRunning);
    final connectedClientCount = useValueListenable(this.connectedClientCount);

    return GestureDetector(
      onTap: isServerRunning ? stopServer : startServer,
      child: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.white38,
            width: .5,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              LucideIcons.radio,
              size: 32,
              color: isServerRunning ? Colors.greenAccent : UIConfig.topBarIconColor,
            ),
            const Gap(8),
            Text(
              isServerRunning
                  ? 'Connected Clients : $connectedClientCount'
                  : 'Start Server',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                letterSpacing: 1,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
