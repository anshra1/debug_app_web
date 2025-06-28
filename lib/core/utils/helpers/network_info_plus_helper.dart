import 'dart:io';
import 'dart:ui';

import 'package:network_info_plus/network_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class NetworkInfoPlusHelper {
  /// Fetches network information based on the platform and permissions.
  ///
  /// Optionally use [onSuccess], [onError], and [onPermissionDenied] callbacks for side effects.
  /// Returns [NetworkInfo] if successful, otherwise `null`.
  static Future<NetworkInfo?> fetchNetworkInfo({
    void Function(NetworkInfo networkInfo)? onSuccess,
    void Function(String error)? onError,
    VoidCallback? onPermissionDenied,
  }) async {
    try {
      final isSupported = Platform.isAndroid ||
          Platform.isIOS ||
          Platform.isMacOS ||
          Platform.isLinux ||
          Platform.isWindows;

      if (!isSupported) {
        onError?.call('This platform is not supported.');
        return null;
      }

      if (Platform.isAndroid) {
        final hasPermission = await _checkAndRequestLocationPermission();
        if (!hasPermission) {
          onPermissionDenied?.call();
          return null;
        }
      }

      if (Platform.isIOS) {
        final status = await Permission.location.status;
        if (!status.isGranted) {
          onPermissionDenied?.call();
          return null;
        }
      }

      final networkInfo = NetworkInfo();

      final wifiName = await networkInfo.getWifiName();
      final wifiIP = await networkInfo.getWifiIP();

      if (wifiName != null && wifiIP != null) {
        onSuccess?.call(networkInfo);
        return networkInfo;
      } else {
        onError?.call('Failed to retrieve network information.');
        return null;
      }
    } on Exception catch (e) {
      onError?.call('An error occurred: $e');
      return null;
    }
  }

  /// Android: Check and request location permission
  static Future<bool> _checkAndRequestLocationPermission() async {
    final status = await Permission.location.status;

    if (status.isGranted) return true;
    if (status.isPermanentlyDenied) return false;

    final result = await Permission.location.request();
    return result.isGranted;
  }
}
