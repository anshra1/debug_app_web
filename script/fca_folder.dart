import 'dart:io';

void main() {
  final directories = [
    'lib/core/constants',
    'lib/core/theme',
    'lib/core/design_system/atoms',
    'lib/core/design_system/molecules',
    'lib/core/design_system/organisms',
    'lib/core/design_system/layout',
    'lib/core/utils/extensions',
    'lib/core/utils/formatters',
    'lib/core/utils/validators',
    'lib/features/home/presentation',
    'lib/features/home/domain',
    'lib/features/home/data',
    'lib/features/auth/presentation',
    'lib/features/auth/domain',
    'lib/features/auth/data',
    'lib/shared/widgets',
    'lib/shared/services',
    'lib/routes',
  ];

  final files = [
    'lib/core/theme/app_colors.dart',
    'lib/core/theme/app_text_styles.dart',
    'lib/core/theme/light_theme.dart',
    'lib/core/theme/dark_theme.dart',
    'lib/core/theme/app_theme.dart',
    'lib/routes/app_routes.dart',
    'lib/routes/route_generator.dart',
    'lib/main.dart',
  ];

  for (final dir in directories) {
    final directory = Directory(dir);
    if (!directory.existsSync()) {
      directory.createSync(recursive: true);
      print('Created directory: ${directory.path}');
    }
  }

  for (final filePath in files) {
    final file = File(filePath);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
      print('Created file: ${file.path}');
    }
  }

  print('\n✅ Folder and file structure created successfully!');
}
