import 'package:debug_app_web/features/setting/setting_sidebar/cubit/setting_cubit.dart';
import 'package:debug_app_web/features/setting/setting_sidebar/enum/side_bar_item_list.dart';
import 'package:debug_app_web/features/setting/setting_sidebar/widgets/side_bar_item_widget.dart';
import 'package:debug_app_web/features/setting/setting_sidebar/widgets/side_bar_view_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SettingSidebar extends HookWidget {
  const SettingSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final currentItem = useValueNotifier(SettingSideBarItemList.workspace);
    return SettingSidebarViewWidget(
      widget: ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: SettingSideBarItemList.values.length,
        itemBuilder: (context, index) {
          final item = SettingSideBarItemList.values[index];

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: HookBuilder(
              builder: (context) {
                useListenable(currentItem);
                return SidebarItemWidget(
                  key: ValueKey(item),
                  label: item.title,
                  icon: const Icon(Icons.settings),
                  config: SidebarItemWidgetConfig.defaultConfig(context),
                  isItemSelected: currentItem.value == item,
                  onTap: () {
                    currentItem.value = item;
                    context.read<SettingCubit>().navigateTo(item);
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
