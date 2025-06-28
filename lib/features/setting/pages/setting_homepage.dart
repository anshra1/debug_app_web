import 'package:debug_app_web/features/setting/cubit/setting_cubit.dart';
import 'package:debug_app_web/features/setting/cubit/setting_state.dart';
import 'package:debug_app_web/features/setting/pages/notification/notification_setting_page.dart';
import 'package:debug_app_web/features/setting/pages/setting_sidebar/setting_sidebar.dart';
import 'package:debug_app_web/features/setting/pages/workspace/workspace_setting_page.dart';
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
    return BlocBuilder<SettingCubit, SettingState>(
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
                _ => const SizedBox.shrink(),
              },
            ),
          ],
        );
      },
    );
  }
}
