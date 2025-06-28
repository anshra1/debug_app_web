import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectivityHelper {
  /// Maps a list of [ConnectivityResult]s to [ConnectivityResult].
  ///
  static ConnectivityResult _getTypeFromResults(List<ConnectivityResult> results) {
    if (results.contains(ConnectivityResult.none)) {
      return ConnectivityResult.none;
    }
    if (results.contains(ConnectivityResult.wifi)) {
      return ConnectivityResult.wifi;
    }
    if (results.contains(ConnectivityResult.mobile)) {
      return ConnectivityResult.mobile;
    }
    if (results.contains(ConnectivityResult.ethernet)) {
      return ConnectivityResult.ethernet;
    }
    if (results.contains(ConnectivityResult.vpn)) {
      return ConnectivityResult.vpn;
    }
    if (results.contains(ConnectivityResult.bluetooth)) {
      return ConnectivityResult.bluetooth;
    }
    if (results.contains(ConnectivityResult.other)) {
      return ConnectivityResult.other;
    }
    return ConnectivityResult.other;
  }

  /// Returns current connectivity status as [ConnectivityResult]
  static Future<ConnectivityResult> getCurrentConnectivityType() async {
    final results = await Connectivity().checkConnectivity();
    return _getTypeFromResults(results);
  }

  /// Stream of connectivity changes as [ConnectivityResult]
  static Stream<ConnectivityResult> onConnectivityTypeChangedStream() {
    return Connectivity().onConnectivityChanged.map(_getTypeFromResults);
  }
}
