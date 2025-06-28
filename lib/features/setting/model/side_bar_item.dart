enum SettingSideBarItem {
  workspace(
    uid: 'workspace',
    icon: 'appearance_icon',
    title: 'Appearance',
  ),
  notification(
    uid: 'notification',
    icon: 'notification_icon',
    title: 'Localization',
  );

  const SettingSideBarItem({
    required this.uid,
    required this.icon,
    required this.title,
  });

  final String uid;
  final String icon;
  final String title;
}
