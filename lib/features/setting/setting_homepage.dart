import 'package:debug_app_web/features/setting/notification/notification_setting_page.dart';
import 'package:debug_app_web/features/setting/setting_sidebar/pages/setting_sidebar_page.dart';
import 'package:debug_app_web/features/setting/shortcuts/page/shortcut_page.dart';
import 'package:debug_app_web/features/setting/setting_sidebar/cubit/setting_cubit.dart';
import 'package:debug_app_web/features/setting/setting_sidebar/cubit/setting_state.dart';
import 'package:debug_app_web/features/setting/workspace/page/workspace_setting_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingHomepage extends StatelessWidget {
  const SettingHomepage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SettingCubit>(
      create: (context) => SettingCubit(),
      child: const SettingHomepageView(),
    );
  }
}

class SettingHomepageView extends StatelessWidget {
  const SettingHomepageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      clipBehavior: Clip.antiAlias,
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.9,
        child: BlocBuilder<SettingCubit, SettingState>(
          builder: (context, state) {
            return Row(
              children: [
                const SizedBox(
                  width: 300,
                  child: SettingSidebar(),
                ),
                Expanded(
                  child: switch (state) {
                    WorkspaceSettingState() => const WorkspaceSettingPage(),
                    NotificationSettingState() => const NotificationSettingPage(),
                    ShortcutsSettingState() => const ShortcutPage(),
                    _ => const SizedBox.shrink(),
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
