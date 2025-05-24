import 'dart:async';
import 'dart:io';

import 'package:logger/logger.dart';

/// This class will encapsulate all WebSocket server logic.
class WebSocketServerService {
  final _logger = Logger();

  final List<WebSocket> _clients = [];

  final _connectionsController = StreamController<int>.broadcast();
  
  HttpServer? _server;

  // Expose the current number of connections
  Stream<int> get connectionsCount => _connectionsController.stream;

  /// Starts the WebSocket server.
  Future<void> startServer(String host, int port) async {
    try {
      _server = await HttpServer.bind(host, port);
      _logger.i('WebSocket server is running at ws://$host:$port');
      _server!.listen(_handleRequest);
    } on Exception catch (e, stack) {
      _logger.e('Failed to start WebSocket server', error: e, stackTrace: stack);
      rethrow;
    }
  }

  /// Handles incoming requests, upgrading them to WebSocket connections.
  Future<void> _handleRequest(HttpRequest request) async {
    if (WebSocketTransformer.isUpgradeRequest(request)) {
      try {
        final socket = await WebSocketTransformer.upgrade(request);
        _addClient(socket);
        _handleClientMessages(socket);
      } on Exception catch (e, stack) {
        _logger.e('Failed to upgrade WebSocket connection', error: e, stackTrace: stack);
      }
    } else {
      _sendForbiddenResponse(request);
    }
  }

  /// Adds a new client to the list and updates the connection count.
  void _addClient(WebSocket socket) {
    _clients.add(socket);
    _connectionsController.add(_clients.length);
    _logger.i('New client connected. Total connections: ${_clients.length}');
    socket.done.then((_) {
      _removeClient(socket);
    });
  }

  /// Handles incoming messages from a client.
  void _handleClientMessages(WebSocket socket) {
    socket.listen(
      (message) {
        _logger.i('Received message: $message');
        _broadcastMessage(message as String); // Broadcast message to all other clients.
      },
      onError: (Object e) {
        _logger.e('Error in message handling: $e');
        _removeClient(socket);
      },
    );
  }

  /// Broadcasts a message to all connected clients, excluding the sender.
  void _broadcastMessage(String message) {
    for (final client in _clients) {
      client.add(message);
    }
  }

  /// Removes a client from the list and updates the connection count.
  void _removeClient(WebSocket socket) {
    _clients.remove(socket);
    _connectionsController.add(_clients.length);
    _logger.i('Client disconnected. Total connections: ${_clients.length}');
  }

  /// Sends a "Forbidden" response if the request is not a WebSocket upgrade.
  void _sendForbiddenResponse(HttpRequest request) {
    request.response
      ..statusCode = HttpStatus.forbidden
      ..write('Only WebSocket connections are allowed')
      ..close();
  }

  /// Stops the WebSocket server and closes all client connections.
  Future<void> stopServer() async {
    try {
      for (final client in _clients) {
        await client.close();
      }
      await _server?.close();
      _logger.i('Server stopped.');
    } on Exception catch (e, stack) {
      _logger.e('Error stopping server', error: e, stackTrace: stack);
    }
  }

  /// Dispose of resources.
  void dispose() {
    stopServer();
    _connectionsController.close();
    _logger.i('Server resources disposed.');
  }
}

void main() async {
  final webSocketServer = WebSocketServerService();

  // Start the server on localhost at port 8080
  await webSocketServer.startServer('localhost', 8080);

  // The server will run indefinitely unless stopped.
  // To stop the server, you can call `webSocketServer.stopServer()`.
}
