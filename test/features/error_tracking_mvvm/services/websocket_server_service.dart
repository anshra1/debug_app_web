// services/websocket_server_service.dart
import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:logger/logger.dart';

import '../model/receiver_model.dart';

class WebSocketServerService {
  HttpServer? _server;
  final _logger = Logger();
  final _errorsController = StreamController<ReceivedErrorModel>.broadcast();
  final _connectionsController = StreamController<int>.broadcast();
  final List<WebSocket> _clients = [];

  Stream<ReceivedErrorModel> get errorStream => _errorsController.stream;
  Stream<int> get connectionsCount => _connectionsController.stream;

  Future<void> startServer(String host, int port) async {
    try {
      _server = await HttpServer.bind(host, port);
      _logger.i('Server started on ws://$host:$port');

      _server!.listen((request) async {
        if (WebSocketTransformer.isUpgradeRequest(request)) {
          final socket = await WebSocketTransformer.upgrade(request);
          _handleConnection(socket);
        }
      });
    } catch (e, stack) {
      _logger.e('Server start failed', stackTrace: stack);
      rethrow;
    }
  }

  void _handleConnection(WebSocket socket) {
    _clients.add(socket);
    _connectionsController.add(_clients.length);

    socket.listen(
      _handleMessage,
      onDone: () => _handleDisconnection(socket),
      onError: (e) {
        _logger.e('Socket error');
        _handleDisconnection(socket);
      },
    );
  }

  void _handleMessage(dynamic message) {
    try {
      final data = jsonDecode(message as String) as Map<String, dynamic>;
      if (data['type'] == 'error_data') {
        final error = ReceivedErrorModel.fromJson(data);
        _errorsController.add(error);
      }
    } on Exception catch (e, stack) {
      _logger.e('Message handling failed', error: e, stackTrace: stack);
    }
  }

  void _handleDisconnection(WebSocket socket) {
    _clients.remove(socket);
    _connectionsController.add(_clients.length);
  }

  Future<void> stop() async {
    for (final client in _clients) {
      await client.close();
    }
    _clients.clear();
    await _server?.close();
    _server = null;
  }

  void dispose() {
    stop();
    _errorsController.close();
    _connectionsController.close();
  }
}
