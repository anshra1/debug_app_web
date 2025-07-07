// import 'package:flutter/material.dart';
// import 'package:toastification/toastification.dart';

// // --- A Generic Builder Function Type ---
// // This defines the "recipe" for building a widget that needs access to
// // the message and progress notifiers.
// typedef ToastWidgetBuilder = Widget Function(
//   BuildContext context,
//   ValueNotifier<String> messageNotifier,
//   ValueNotifier<double> progressNotifier,
// );

// // --- 1. The Controller (The Service) ---
// // Now decoupled from any specific UI widget.
// class LoadingToastService {
//   LoadingToastService(this.toastification);
//   final Toastification toastification;

//   // --- State Management ---
//   final ValueNotifier<double> _progressNotifier = ValueNotifier(0);
//   final ValueNotifier<String> _messageNotifier = ValueNotifier('');
//   ToastificationItem? _toastItem;

//   /// The show method now requires a `builder` function.
//   void show(
//     BuildContext context, {
//     required ToastWidgetBuilder builder, // The UI is now provided by the caller
//     String initialMessage = 'Loading...', required String message,
//   }) {
//     if (_toastItem != null) {
//       update(message: initialMessage);
//       return;
//     }

//     _messageNotifier.value = initialMessage;
//     _progressNotifier.value = 0.0;

//     _toastItem = toastification.showCustom(
//       context: context,
//       config: const ToastificationConfig(
//         blockBackgroundInteraction: true,
//         alignment: Alignment.center,
//       ),
//       // The service calls the user-provided builder and passes its notifiers.
//       builder: (context, item) {
//         return builder(context, _messageNotifier, _progressNotifier);
//       },
//     );
//   }

//   /// Updates the state. Any widget listening will automatically update.
//   void update({String? message, double? progress}) {
//     if (_toastItem == null) return;

//     if (message != null) {
//       _messageNotifier.value = message;
//     }
//     if (progress != null) {
//       _progressNotifier.value = progress;
//     }
//   }

//   void hide() {
//     if (_toastItem != null) {
//       toastification.dismiss(_toastItem!);
//       _toastItem = null;
//     }
//   }

//   void dispose() {
//     _progressNotifier.dispose();
//     _messageNotifier.dispose();
//   }
// }
