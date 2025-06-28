// import 'package:flutter/material.dart';
// import 'package:theme_ui_widgets/theme_ui_widgets.dart';

// void main() {
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return CustomAppTheme(
//       data: AppDefaultTheme().dark(),
//       child: const MaterialApp(
//         home: HomePage(),
//       ),
//     );
//   }
// }

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: CustomAppTheme.of(context).backgroundColorScheme.primary,
//       body: const Center(child: Text('Hello, World!')),
//     );
//   }
// }

// extension on String {
//   Color hexToColor() {
//     final hexColor = replaceAll('#', '');
//     final colorHex =
//         hexColor.length == 6 ? 'FF$hexColor' : hexColor; // Add alpha channel if needed
//     return Color(int.parse(colorHex, radix: 16));
//   }
// }
