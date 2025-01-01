// ignore_for_file: avoid_print

import 'package:debug_app_web/src/core/extension/stack_trace.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Shell Functions Example')),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              try {
                throw Exception('Simulated error');
              } catch (e, s) {
                print('Caught error: $e');
                print('StackTrace: ${s.readable}');
              }
            },
            child: const Text('Execute Command'),
          ),
        ),
      ),
    );
  }
}
