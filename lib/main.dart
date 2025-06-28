import 'package:debug_app_web/core/di/depandency_injection.dart';
import 'package:debug_app_web/root_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    FlutterError.onError = (FlutterErrorDetails details) {
      // In a real app, log this to a crash reporting service (e.g., Sentry)
      debugPrint('Flutter error: ${details.exceptionAsString()}');
    }; // Initialize dependencies first

    // await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    await init();

    runApp(const RootApp());
  } catch (error, stackTrace) {
    FlutterError.reportError(
      FlutterErrorDetails(
        exception: error,
        library: 'Flutter test framework',
        context: ErrorSummary('while running async test code'),
      ),
    );

    runApp(
      MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('Error initializing app: $error $stackTrace'),
          ),
        ),
      ),
    );
  }
}
