import 'package:debug_app_web/core/wrappers/base/app_wrapper.dart';
import 'package:flutter/material.dart';

/// Main widget that orchestrates the application of multiple wrappers
/// Handles ordering and application of wrappers in a clean, maintainable way
class AppWrappers extends StatelessWidget {
  const AppWrappers({
    required this.wrappers,
    required this.child,
    super.key,
  });
  final List<AppWrapper> wrappers;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    // STEP 1: Sort wrappers by priority
    // Example: If we have wrappers with priorities [3,1,2]
    // After sorting we get [1,2,3]
    final sortedWrappers = List<AppWrapper>.from(wrappers)
      ..sort((a, b) => a.priority.compareTo(b.priority));

    // STEP 2: Apply wrappers in sequence using fold
    // fold starts with the child widget and applies each wrapper in turn
    // For example, with 3 wrappers, the process is:
    // Initial:  child
    // Step 1:   wrapper1.wrap(context, child)
    // Step 2:   wrapper2.wrap(context, result_of_step1)
    // Step 3:   wrapper3.wrap(context, result_of_step2)
    return sortedWrappers.fold<Widget>(
      child,
      (wrappedChild, wrapper) => wrapper.wrap(context, wrappedChild),
    );
  }
}
