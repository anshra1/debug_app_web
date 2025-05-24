// viewmodels/error_receiver_view_model.dart
import 'package:flutter/material.dart';

import '../model/receiver_model.dart';
import '../services/websocket_server_service.dart';

class ErrorReceiverViewModel extends ChangeNotifier {
  ErrorReceiverViewModel(this._service) {
    _setupListeners();
  }
  final WebSocketServerService _service;
  final List<ReceivedErrorModel> _errors = [];
  bool _isServerRunning = false;
  int _connectionCount = 0;
  String _serverUrl = '0.0.0.0';
  int _serverPort = 9999;
  String? _lastError;

  List<ReceivedErrorModel> get errors => List.unmodifiable(_errors);
  bool get isServerRunning => _isServerRunning;
  int get connectionCount => _connectionCount;
  String get serverUrl => _serverUrl;
  int get serverPort => _serverPort;
  String? get lastError => _lastError;

  void _setupListeners() {
    _service.errorStream.listen((error) {
      _errors.add(error);
      notifyListeners();
    });

    _service.connectionsCount.listen((count) {
      _connectionCount = count;
      notifyListeners();
    });
  }

  Future<void> startServer({String? host, int? port}) async {
    try {
      _serverUrl = host ?? _serverUrl;
      _serverPort = port ?? _serverPort;

      await _service.startServer(_serverUrl, _serverPort);
      _isServerRunning = true;
      _lastError = null;
      notifyListeners();
    }on Exception catch (e) {
      _lastError = e.toString();
      _isServerRunning = false;
      notifyListeners();
    }
  }

  Future<void> stopServer() async {
    await _service.stop();
    _isServerRunning = false;
    notifyListeners();
  }

  void clearErrors() {
    _errors.clear();
    notifyListeners();
  }
}
