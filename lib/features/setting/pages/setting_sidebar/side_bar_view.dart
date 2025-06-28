import 'package:debug_app_web/features/setting/pages/setting_sidebar/side_bar_item.dart';
import 'package:flutter/material.dart';

class SettingSidebarWidget extends StatelessWidget {
  const SettingSidebarWidget({
    required this.children,
    super.key,
    this.width = 280.0,
    this.backgroundColor,
    this.padding = const EdgeInsets.all(16),
  });

  final List<Widget> children;
  final double width;
  final Color? backgroundColor;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final effectiveBackgroundColor = backgroundColor ??
        (Theme.of(context).brightness == Brightness.dark
            ? const Color(0xFF1F2937)
            : const Color(0xFFFAFAFA));

    return Container(
      width: width,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        border: Border(
          right: BorderSide(
            color: Theme.of(context).dividerColor,
          ),
        ),
      ),
      child: Padding(
        padding: padding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: children,
        ),
      ),
    );
  }
}

// =============================================================================
// EXAMPLE USAGE
// =============================================================================

/// Example showing how to use the AppFlowy sidebar items
class SettingSidebarView extends StatefulWidget {
  const SettingSidebarView({required List<ListTile> children, super.key});

  @override
  State<SettingSidebarView> createState() => _SettingSidebarViewState();
}

class _SettingSidebarViewState extends State<SettingSidebarView> {
  int selectedIndex = 0;

  final List<_SidebarItemData> items = [
    _SidebarItemData('Account', Icons.person_outline),
    _SidebarItemData('Workspace', Icons.work_outline),
    _SidebarItemData('Appearance', Icons.palette_outlined),
    _SidebarItemData('Shortcuts', Icons.keyboard_outlined),
    _SidebarItemData('AI Assistant', Icons.smart_toy_outlined),
    _SidebarItemData('Notifications', Icons.notifications_outlined),
    _SidebarItemData('Privacy', Icons.security_outlined),
    _SidebarItemData('About', Icons.info_outline),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SettingSidebarWidget(
            children: [
              const Text(
                'Settings',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              ...items.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 4),
                  child: SidebarItem(
                    label: item.label,
                    icon: Icon(item.icon),
                    config: AppSidebarItemConfig.defaultConfig(context),
                    isSelected: selectedIndex == index,
                    onTap: () => setState(() => selectedIndex = index),
                  ),
                );
              }),
            ],
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    items[selectedIndex].label,
                    style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Content for ${items[selectedIndex].label} page would go here.',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SidebarItemData {
  _SidebarItemData(this.label, this.icon);
  final String label;
  final IconData icon;
}
