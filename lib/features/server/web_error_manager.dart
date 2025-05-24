import 'dart:convert';

import 'package:debug_app_web/features/home/domain/entity/current_error.dart';
import 'package:debug_app_web/features/home/domain/entity/error_environment.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/status.dart' as status;
import 'package:web_socket_channel/web_socket_channel.dart';

class WebErrorManager extends ChangeNotifier {
  factory WebErrorManager() => platform;
  WebErrorManager._internal();

  static final WebErrorManager platform = WebErrorManager._internal();

  String kIp = '';
  int kPort = 0;

  WebSocketChannel? _channel;
  bool _isConnected = false;

  bool get isConnected => _isConnected;

  /// Initializes the WebSocket connection if not already connected.
  Future<void> initConnection({
    required String ip,
    required int port,
  }) async {
    if (_isConnected) return;

    kIp = ip;
    kPort = port;

    try {
      final uri = Uri.parse('ws://$kIp:$kPort');
      _channel = WebSocketChannel.connect(uri);
      _isConnected = true;
      debugPrint('WebSocket connected to $uri');

      _channel!.stream.listen(
        (event) {
          debugPrint('Message from server: $event');
        },
        onError: (error) {
          debugPrint('WebSocket error: $error');
          _isConnected = false;
          notifyListeners();
        },
        onDone: () {
          debugPrint('WebSocket connection closed');
          _isConnected = false;
          notifyListeners();
        },
      );

      notifyListeners();
    } on Exception catch (e) {
      debugPrint('Connection failed: $e');
      _isConnected = false;
      notifyListeners();
    }
  }

  /// Sends an error message to the server via WebSocket.
  Future<void> sendError({
    required Object error,
    required StackTrace stackTrace,
  }) async {
    if (!_isConnected || _channel == null) {
      debugPrint('WebSocket not connected. Call initConnection first.');
      return;
    }

    try {
      const environment = ErrorEnvironment(
        flutterVersion: '3.19.5',
        dartVersion: '2.22',
        platform: 'linux',
        osVersion: 'linuxInfo.machineId',
        deviceModel: 'linuxInfo.buildId',
      );

      final currentError = CurrentError(
        error: error.toString(),
        stackTrace: stackTrace.toString(),
        environment: environment,
        date: DateTime.now(),
      );

      debugPrint(currentError.toString());

      final jsonData = jsonEncode(currentError.toJson());
      _channel!.sink.add(jsonData);
      // print(jsonData);
      debugPrint('Error sent');
    } on Exception catch (e) {
      debugPrint('Error sending message: $e');
    }
  }

  void changeIpAndPort({
    required String ip,
    required int port,
  }) {
    debugPrint('IP and port changed to $ip:$port');
    kIp = ip;
    kPort = port;
  }

  void closeConnection() {
    _channel?.sink.close(status.goingAway);
    _isConnected = false;
    notifyListeners();
  }

  bool isConnectedToServer() => _isConnected;
}
