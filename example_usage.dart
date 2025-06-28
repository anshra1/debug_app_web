// // Initialize theme manager
// import 'package:debug_app_web/core/services/file_manager/file_manager.dart';
// import 'package:debug_app_web/core/theme/themes/theme_manager.dart';

// final fileManager = await FileManagerSetup.create();
// final themeManager = ThemeManager(fileManager: fileManager);

// // Get all themes
// final allThemes = await themeManager.getAllThemes();
// print('Found ${allThemes.length} themes');

// // Find specific theme
// final darkTheme = await themeManager.findThemeByName('Dark Mode');

// // Upload custom theme
// final customTheme = CustomAppTheme(
//   builtIn: false,
//   themeName: 'My Custom Theme',
//   lightTheme: myLightTheme,
//   darkTheme: myDarkTheme,
// );
// await themeManager.uploadCustomTheme(customTheme);

// // Delete custom theme
// await themeManager.deleteCustomTheme('My Custom Theme');

// // Get theme statistics
// final stats = await themeManager.getThemeStats();
// print('Built-in: ${stats['builtIn']}, Custom: ${stats['custom']}'); 