import 'package:debug_app_web/features/setting/cubit/setting_state.dart';
import 'package:debug_app_web/features/setting/model/side_bar_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingCubit extends Cubit<SettingState> {
  SettingCubit() : super(const WorkspaceSettingState());

  final SettingSideBarItem currentItem = SettingSideBarItem.workspace;

  void navigateTo(SettingSideBarItem item) {
    emit(const SettingLoading());
    switch (item) {
      case SettingSideBarItem.workspace:
        emit(const WorkspaceSettingState());

      case SettingSideBarItem.notification:
        emit(const NotificationSettingState());
    }
  }
}
