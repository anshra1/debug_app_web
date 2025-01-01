import 'package:flutter/foundation.dart';
import 'package:stack_trace/stack_trace.dart';

class Config {
  static const bool isDebug = true;
}

class ShellFunctions {
  static T executeAsyncOperation<T>(T Function() action) {
    return _runWithCapture<T>(() {
      return _executeCommandInternal(action);
    });
  }

  static T _executeCommandInternal<T>(T Function() action) {
    return action();
  }

  static T _runWithCapture<T>(T Function() action) {
    if (Config.isDebug) {
      return Chain.capture(
        () => action(),
        onError: (error, chain) {
          _handleError(error, chain);
          _defaultReturnValue<T>();
        },
      );
    } else {
      return action();
    }
  }

  static void _handleError(Object error, Chain chain) {
    if (kDebugMode) {
    print('Caught error: $error');
      print(chain.terse); // Use Chain.terse to simplify the stack trace
    }
  }

  static T _defaultReturnValue<T>() {
    if (T == bool) return false as T;
    if (T == String) return 'Error occurred' as T;
    if (T == List<String>) return <String>[] as T;
    if (T == Map<String, dynamic>) return <String, dynamic>{} as T;
    return null as T; // Default case
  }
}
