enum SettingSideBarItemList {
  workspace(
    uid: 'workspace',
    icon: 'appearance_icon',
    title: 'Appearance',
  ),
  shortcuts(
    uid: 'shortcuts',
    icon: 'shortcuts_icon',
    title: 'Shortcuts',
  ),
  notification(
    uid: 'notification',
    icon: 'notification_icon',
    title: 'Localization',
  );

  const SettingSideBarItemList({
    required this.uid,
    required this.icon,
    required this.title,
  });

  final String uid;
  final String icon;
  final String title;
}
