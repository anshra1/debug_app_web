// ignore_for_file: avoid_print7u6yeda


import 'dart:io';

void main() async {
  // List of file paths to read
  final filePaths = <String>[
    '/home/ansh/Studio Projects/Clone/debug_app_web/lib/src/features/error_tracking/data/models/comment_model.dart',
    '/home/ansh/Studio Projects/Clone/debug_app_web/lib/src/features/error_tracking/data/models/solution_model.dart',
    '/home/ansh/Studio Projects/Clone/debug_app_web/lib/src/features/error_tracking/data/models/error_tracking_entity_model.dart',
    '/home/ansh/Studio Projects/Clone/debug_app_web/lib/src/features/error_tracking/data/models/error_tracking_dates_model.dart',
    '/home/ansh/Studio Projects/Clone/debug_app_web/lib/src/features/error_tracking/data/models/error_environment_model.dart',
    '/home/ansh/Studio Projects/Clone/debug_app_web/lib/src/features/error_tracking/data/models/error_details_model.dart',
  ];

  // Path for the new combined file
  const combinedFilePath =
      '/home/ansh/Studio Projects/Clone/debug_app_web/lib/src/features/error_tracking/data/models/combined_model.dart';

  // Create a new file
  final combinedFile = File(combinedFilePath);
  final sink = combinedFile.openWrite();

  // Read and combine the contents of each file
  for (final path in filePaths) {
    final file = File(path);
    if (file.existsSync()) {
      final contents = await file.readAsString();
      sink
        ..write(contents)
        ..write('\n\n'); // Add some spacing between files
    } else {
      print('File not found: $path');
    }
  }

  // Close the sink
  await sink.close();
  print('Combined file created at: $combinedFilePath');
}
