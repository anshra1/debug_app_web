import 'package:debug_app_web/features/setting/cubit/setting_cubit.dart';
import 'package:debug_app_web/features/setting/model/side_bar_item.dart';
import 'package:debug_app_web/features/setting/pages/setting_sidebar/side_bar_item.dart';
import 'package:debug_app_web/features/setting/pages/setting_sidebar/side_bar_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class SettingSidebar extends HookWidget {
  const SettingSidebar({super.key});

  @override
  Widget build(BuildContext context) {
    final currentItem = useState(context.read<SettingCubit>().currentItem);
    return SettingSidebarWidget(
      backgroundColor: Theme.of(context).colorScheme.surface,
      children: SettingSideBarItem.values.map((item) {
        return SidebarItem(
          label: item.title,
          icon: const Icon(Icons.settings),
          config: AppSidebarItemConfig.defaultConfig(context),
          isSelected: currentItem.value == item,
          onTap: () {
            currentItem.value = item;
            context.read<SettingCubit>().navigateTo(item);
          },
        );
      }).toList(),
    );
  }
}
