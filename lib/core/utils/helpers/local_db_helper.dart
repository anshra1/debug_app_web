import 'package:shared_preferences/shared_preferences.dart';

class LocalDbHelper {
  static const String _portKey = 'server_port';
  static const int _defaultPort = 2323;

  /// Stores the port number
  static Future<void> setPort(int port) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_portKey, port);
  }

  /// Retrieves the port number. Returns 2323 if not set.
  static Future<int> getPort() async {
    final prefs = await SharedPreferences.getInstance();
    final port = prefs.getInt(_portKey);
    if (port == null) {
      await prefs.setInt(_portKey, _defaultPort);
      return _defaultPort;
    }
    return port;
  }

  /// Removes the stored port number
  static Future<void> removePort() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_portKey);
  }
}
