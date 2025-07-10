import 'package:flutter/material.dart';

/// Base interface for all app wrappers.
/// This defines the contract that all wrapper implementations must follow.
abstract class AppWrapper {
  /// Wraps the given child widget with specific functionality
  /// @param context The build context
  /// @param child The widget to wrap
  /// @returns The wrapped widget
  Widget wrap(BuildContext context, Widget child);

  /// Priority determines the order in which wrappers are applied
  /// Lower numbers run first
  /// @returns The priority value
  int get priority => 0;
}
