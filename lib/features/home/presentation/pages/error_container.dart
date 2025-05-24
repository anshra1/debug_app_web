import 'package:baby_package/baby_package.dart';
import 'package:debug_app_web/features/home/domain/entity/current_error.dart';
import 'package:debug_app_web/features/home/presentation/widget/error_card.dart';
import 'package:debug_app_web/features/home/presentation/widget/stack_trace_card.dart';
import 'package:flutter/material.dart';

class ErrorContainer extends StatelessWidget {
  const ErrorContainer({required this.currentError, super.key});

  final CurrentError? currentError;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.theme.colorScheme.surface,
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: const Padding(
              padding: EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ErrorCard(
                    errorMessage:
                        'Socket Exception MissingPluginException: No implementation found for method xyz on channel',
                    fileLocation:
                        'lib/features/home/presentation/pages/example_file.dart',
                    method: 'getFetchData()',
                    networkError: 'Unable to connect to the server.',
                    timestamp: '2025-05-24 14:15:19.857458',
                    darkMode: false,
                  ),
                  StackTraceCard(
                    trace:
                        'Exception: Unable to connect to the server.\nStack trace:\n  at main (package:app/main.dart:10)\n  at _runMainZoned (dart:ui/hooks.dart:134)\n  at runApp (package:flutter/src/widgets/binding.dart:883)\n  at main (package:app/main.dart:5)',
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
