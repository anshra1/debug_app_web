// import 'package:debug_app_web/features/server/web_error_manager.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_hooks/flutter_hooks.dart';
// import 'package:provider/provider.dart';

// class WebRoot extends StatelessWidget {
//   const WebRoot({required this.child, required this.ip, required this.port, super.key});

//   final Widget child;
//   final String ip;
//   final int port;

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (_) => WebErrorManager()),
//       ],
//       child: WebDotWidget(
//         ip: ip,
//         port: port,
//         child: child,
//       ),
//     );
//   }
// }

// class WebDotWidget extends HookWidget {
//   const WebDotWidget({
//     required this.child,
//     required this.ip,
//     required this.port,
//     super.key,
//   });

//   final Widget child;
//   final String ip;
//   final int port;

//   @override
//   Widget build(BuildContext context) {
//     // Initialize connection once
//     useEffect(
//       () {
//         WebErrorManager.platform.initConnection(ip: ip, port: port);
//         return null;
//       },
//       [],
//     );

//     // ValueNotifier for position
//     final position = useValueNotifier<Offset>(const Offset(100, 100));

//     return Stack(
//       children: [
//         child,

//         // Draggable floating icon
//         ValueListenableBuilder<Offset>(
//           valueListenable: position,
//           builder: (context, value, _) {
//             return Positioned(
//               left: value.dx,
//               top: value.dy,
//               child: GestureDetector(
//                 onPanUpdate: (details) {
//                   position.value += details.delta;
//                 },
//                 child: Consumer<WebErrorManager>(
//                   builder: (context, manager, child) {
//                     return ElevatedButton.icon(
//                       onPressed: () {
//                         WebErrorManager.platform.initConnection(ip: ip, port: port);
//                         debugPrint('init');
//                       },
//                       icon: Icon(
//                         Icons.circle,
//                         color: manager.isConnected ? Colors.green : Colors.red,
//                         size: 80,
//                       ),
//                       label: const Text('init'),
//                     );
//                   },
//                 ),
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }
