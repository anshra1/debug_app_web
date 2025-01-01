import 'dart:io';

import 'package:flutter/foundation.dart';

void main() async {
  // Define the base directory
  const baseDir =
      '/home/ansh/Studio Projects/Clone/debug_app_web/test2/src/features/error_tracking/data/models';

  // Create the directory and its subdirectories if they do not exist
  Directory(baseDir).createSync(recursive: true);

  // List of file paths to create
  final filePaths = <String>[
    '$baseDir/comment_model_test.dart',
    '$baseDir/solution_model_test.dart',
    '$baseDir/error_tracking_entity_model_test.dart',
    '$baseDir/error_tracking_dates_model_test.dart',
    '$baseDir/error_environment_model_test.dart',
    '$baseDir/error_details_model_test.dart',
  ];

  // Create each file
  for (final path in filePaths) {
    File(path).createSync();
    if (kDebugMode) {
      print('Created: $path');
    }
  }
}
