import 'package:debug_app_web/features/setting/setting_sidebar/cubit/setting_state.dart';
import 'package:debug_app_web/features/setting/setting_sidebar/enum/side_bar_item_list.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(const WorkspaceSettingState());

  final SettingSideBarItemList currentItem = SettingSideBarItemList.workspace;

  void navigateTo(SettingSideBarItemList item) {
    emit(const SettingLoading());
    switch (item) {
      case SettingSideBarItemList.workspace:
        emit(const WorkspaceSettingState());

      case SettingSideBarItemList.notification:
        emit(const NotificationSettingState());
      case SettingSideBarItemList.shortcuts:
        emit(const ShortcutsSettingState());
    }
  }
}
