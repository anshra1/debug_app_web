import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionShell {
  Future<void> saveFile({
    required Future<void> Function() androidLogic,
    required Future<void> Function() iosLogic,
  }) async {
    try {
      if (Platform.isAndroid) {
        // Check if the app is running on Android
        // and get the Android SDK version
        final sdkVersion = await _getAndroidSdkVersion();
        // Check if the app is running on Android 11 or higher
        // and request the necessary permissions
        final hasPermission = await _handleAndroidPermissions(sdkVersion);

        if (hasPermission) {
          await androidLogic();
        } else {
          if (sdkVersion >= 30) {
            // Only open settings for Android 11+
            await openAppSettings();
          } else {
            debugPrint('Storage permission required for Android <11');
            // Consider showing a dialog instead of SnackBar for better UX
          }
        }
      } else if (Platform.isIOS) {
        await iosLogic();
      }
    } on PlatformException catch (e) {
      debugPrint('Permission error: ${e.message}');
      rethrow;
    }
    return Future.value();
  }

  Future<bool> _handleAndroidPermissions(int sdkVersion) async {
    // if android version is 30 or above, check for manageExternalStorage permission
    // else check for storage permission
    final requiredPermission =
        sdkVersion >= 30 ? Permission.manageExternalStorage : Permission.storage;

    return requiredPermission.isGranted;
  }

  /// Get the Android SDK version
  /// This method uses the device_info_plus package to retrieve the SDK version.
  Future<int> _getAndroidSdkVersion() async {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    return deviceInfo.version.sdkInt;
  }
}

class PermissionShells {
  PermissionShells({required this.context});
  final BuildContext context;

  /// Executes platform-specific logic after checking and requesting permissions.
  ///
  /// [androidLogic] - Function to run on Android if permission is granted
  /// [iosLogic] - Function to run on iOS if permission is granted
  /// [onPermissionDenied] - Optional callback when permission is denied
  Future<void> saveFile({
    required Future<void> Function() androidLogic,
    required Future<void> Function() iosLogic,
    VoidCallback? onPermissionDenied,
  }) async {
    try {
      if (Platform.isAndroid) {
        final sdkVersion = await _getAndroidSdkVersion();
        final hasPermission = await _handleAndroidPermissions(sdkVersion);

        if (hasPermission) {
          await androidLogic();
        } else {
          // Show a dialog or snackbar if permission is not granted
          _showPermissionDialog(
            title: 'Permission Required',
            message: 'Please grant storage permission to proceed.',
            onOkPressed: () async {
              final status = await _requestAndroidPermissions(sdkVersion);
              if (status.isGranted) {
                await androidLogic();
              } else {
                onPermissionDenied?.call();
              }
            },
          );
        }
      } else if (Platform.isIOS) {
        await iosLogic();
      }
    } on PlatformException catch (e) {
      debugPrint('Permission error: ${e.message}');
      _showSnackBar('An error occurred while checking permissions.');
      rethrow;
    }
  }

  /// Shows a dialog to request permission
  void _showPermissionDialog({
    required String title,
    required String message,
    required VoidCallback onOkPressed,
  }) {
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: Navigator.of(context).pop,
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: onOkPressed,
            child: const Text('Allow'),
          ),
        ],
      ),
    );
  }

  /// Shows a SnackBar with the given message
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /// Handles Android permission checks based on SDK version
  Future<bool> _handleAndroidPermissions(int sdkVersion) async {
    final requiredPermission =
        sdkVersion >= 30 ? Permission.manageExternalStorage : Permission.storage;

    final status = await requiredPermission.status;

    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      _showSnackBar('Storage permission is permanently denied.');
      return false;
    } else {
      return false;
    }
  }

  /// Requests Android permission based on SDK version
  Future<PermissionStatus> _requestAndroidPermissions(int sdkVersion) async {
    final requiredPermission =
        sdkVersion >= 30 ? Permission.manageExternalStorage : Permission.storage;

    final status = await requiredPermission.request();

    if (status.isGranted) {
      _showSnackBar('Storage permission granted.');
    } else if (status.isPermanentlyDenied) {
      _showSnackBar('Storage permission is permanently denied.');
    } else {
      _showSnackBar('Storage permission denied.');
    }

    return status;
  }

  /// Get the Android SDK version
  Future<int> _getAndroidSdkVersion() async {
    final deviceInfo = await DeviceInfoPlugin().androidInfo;
    return deviceInfo.version.sdkInt;
  }
}
