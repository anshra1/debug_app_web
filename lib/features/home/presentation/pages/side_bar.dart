import 'package:debug_app_web/core/config/central_ui.dart';
import 'package:flutter/material.dart';

class SideBarContainer extends StatelessWidget {
  const SideBarContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: UIConfig.sideBarWidth,
      height: double.infinity,
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: ListView.builder(
        itemCount: 10,
        itemBuilder: (context, index) {
          return SizedBox(
            height: UIConfig.sidebarListItemHeight,
            child: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: UIConfig.sidebarItemBackgroundColor,
                borderRadius: BorderRadius.circular(UIConfig.sidebarListItemBorderRadius),
              ),
              child: Center(
                child: Text(
                  'ListView $index',
                  style: const TextStyle(
                    color: UIConfig.sidebarTextColor,
                    fontSize: UIConfig.sidebarFontSize,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
