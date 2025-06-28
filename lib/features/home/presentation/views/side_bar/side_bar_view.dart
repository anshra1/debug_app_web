import 'package:debug_app_web/core/config/central_ui.dart';
import 'package:debug_app_web/features/home/data/datasource/remote_data_source/server_rds.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SideBarView extends HookWidget {
  const SideBarView({
    required this.isExpanded,
    super.key,
  });

  final ValueNotifier<bool> isExpanded;

  @override
  Widget build(BuildContext context) {
    final isExpandeds = useValueListenable(isExpanded);

    return !isExpandeds
        ? const SizedBox.shrink()
        : Column(
            children: [
              // Container(
              //   padding: const EdgeInsets.symmetric(horizontal: 8),
              //   width: double.infinity,
              //   height: UIConfig.topBarHeight,
              //   color: UIConfig.sidebarListItemColor,
              //   child: const Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     mainAxisSize: MainAxisSize.min,
              //     children: [
              //       Text(
              //         'Debug App',
              //         style: TextStyle(
              //           color: Colors.white,
              //         ),
              //       ),
              //       Spacer(),
              //       Icon(
              //         LucideIcons.layoutDashboard,
              //         size: 30,
              //         weight: 50,
              //         color: UIConfig.sidebarTextColor,
              //       ),
              //     ],
              //   ),
              // ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(top: 6),
                  width: UIConfig.sideBarWidth,
                  color: UIConfig.sidebarBackgroundColor,
                  child: ListView.builder(
                    itemCount: errorTrackingList.length,
                    itemBuilder: (context, index) {
                      return SideBarTile(
                        error: errorTrackingList[index].currentError.error,
                      );
                    },
                  ),
                ),
              ),
            ],
          );
  }
}

class SideBarTile extends StatelessWidget {
  const SideBarTile({
    required this.error,
    super.key,
  });

  final String error;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: UIConfig.sidebarListTileColor,
          borderRadius: BorderRadius.circular(8),
        ),
        child: ListTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            error,
            style: const TextStyle(
              fontWeight: FontWeight.w500,
              color: UIConfig.sidebarTextColor,
            ),
          ),
          onTap: () {
            // Add your onTap functionality here
          },
        ),
      ),
    );
  }
}

final List<String> flutterErrors = [
  "NoSuchMethodError: The getter 'length' was called on null.",
  'FormatException: Invalid date format.',
  'RangeError (index): Index out of range.',
  'StateError: No element.',
  'AssertionError: A non-null String must be provided.',
  "TypeError: type 'String' is not a subtype of type 'int'.",
  'MissingPluginException(No implementation found for method ...)',
  'FlutterError: Unable to load asset: assets/images/logo.png.',
  'HttpException: Connection failed.',
  'TimeoutException: The connection has timed out.',
];
