sealed class SettingState {
  const SettingState();
}

class SettingInitial extends SettingState {
  const SettingInitial();
}

class SettingLoading extends SettingState {
  const SettingLoading();
}

class SettingError extends SettingState {
  const SettingError();
}

class NotificationSettingState extends SettingState {
  const NotificationSettingState();
}

class WorkspaceSettingState extends SettingState {
  const WorkspaceSettingState();
}
