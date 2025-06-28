// // lib/widgets/app_button.dart

// import 'package:debug_app_web/root_app.dart';
// import 'package:flutter/material.dart';
// import 'package:storybook_flutter/storybook_flutter.dart';

// class AppButton extends StatelessWidget {
//   const AppButton({
//     required this.label,
//     required this.onPressed,
//     super.key,
//     this.color = Colors.blue,
//   });
//   final String label;
//   final VoidCallback onPressed;
//   final Color color;

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       style: ElevatedButton.styleFrom(backgroundColor: color),
//       child: Text(label),
//     );
//   }
// }

// // lib/stories/app_button_story.dart

// final appButtonStory = Story(
//   name: 'AppButton',
//   builder: (context) {
//     final label = context.knobs.text(label: 'Label', initial: 'Click me');
//     final color = context.knobs.options<Color>(
//       label: 'Color',
//       initial: Colors.blue,
//       options: const [
//         Option(label: 'Blue', value: Colors.blue),
//         Option(label: 'Red', value: Colors.red),
//         Option(label: 'Green', value: Colors.green),
//       ],
//     );

//     return const RootApp();
//   },
// );

// // lib/storybook_main.dart

// void main() {
//   runApp(const StorybookApp());
// }

// class StorybookApp extends StatelessWidget {
//   const StorybookApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Storybook Example',
//       home: Storybook(
//         stories: [
//           appButtonStory,
//         ],
//       ),
//     );
//   }
// }
