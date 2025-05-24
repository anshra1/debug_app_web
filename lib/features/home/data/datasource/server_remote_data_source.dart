import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:debug_app_web/core/constants/keys.dart';
import 'package:debug_app_web/features/home/domain/entity/current_error.dart';
import 'package:debug_app_web/features/home/domain/entity/error_tracking.dart';
import 'package:flutter/material.dart' show debugPrint;
import 'package:logger/logger.dart';

abstract class ServerRepositoryRemoteDataSource {
  Future<bool> startServer({required String host, required int port});

  Future<bool> stopServer();

  Future<List<ErrorTracking>> showTodyErrorList();

  Future<bool> unblockClient(String clientId);

  Future<bool> forceDisconnect(String clientId);

  Stream<int> getConnectedClients();

  Stream<CurrentError> getCurrentError();

  Stream<List<ErrorTracking>> getErrorTracking();
}

class ServerRemoteDataSourceImpl extends ServerRepositoryRemoteDataSource {
  final _logger = Logger();

  final List<WebSocket> _clients = [];
  late HttpServer server;

  final _connectionsController = StreamController<int>.broadcast();
  final _errorMessageController = StreamController<CurrentError>.broadcast();

  // Expose the current number of connections
  Stream<int> get connectionsCount => _connectionsController.stream;

  bool _isServerRunning = false;

  @override
  Future<bool> startServer({
    required String host,
    required int port,
  }) async {
    try {
      // checking if the server is already running
      if (_isServerRunning) {
        _logger.e('Server is already running');
        return false;
      }

      // starting the server
      server = await HttpServer.bind('0.0.0.0', 3000);
      await listenToServer();
      _logger.i('Server started on $host:$port');
      return true;
    } on Exception catch (e, stack) {
      _isServerRunning = false;
      _logger.e('Failed to start WebSocket server', error: e, stackTrace: stack);
      rethrow;
    }
  }

  Future<void> listenToServer() async {
    server.listen(
      (httpRequest) async {
        _isServerRunning = true;

        // httpRequest is the request from the client
        // here we are checking if the request is a web socket upgrade request
        if (!WebSocketTransformer.isUpgradeRequest(httpRequest)) {
          _logger.e('Not a WebSocket upgrade request');
          return;
        }

        try {
          //  conect to a web socket server after the request is upgraded
          final webSocket = await WebSocketTransformer.upgrade(httpRequest);

          // adding the socket to the list of clients
          _addClient(webSocket);

          //  handling the client messages
          _handleClientAndMessages(webSocket);
        } on Exception catch (e, stack) {
          _logger.e(
            'Failed to upgrade WebSocket conn ection',
            error: e,
            stackTrace: stack,
          );
        }
      },
      onDone: () {
        _isServerRunning = false;
      },
      onError: (Object e, StackTrace stackTrace) {
        _isServerRunning = false;
        _logger.e('Error in server listening: $e', stackTrace: stackTrace);
      },
      cancelOnError: true,
    );
  }

  void _addClient(WebSocket socket) {
    _clients.add(socket);
    _connectionsController.add(_clients.length);
  }

  void _handleClientAndMessages(WebSocket socket) {
    socket.listen(
      (message) {
        //  _logger.i('Received message: $message');
        final currentError = safeParseCurrentError(message as String);

        // check if the message is a CurrentError
        if (currentError != null) {

          _errorMessageController.add(currentError);
          
        } else {
          _logger.e('Failed to parse CurrentError');
        }
      },
      onDone: () {
        _clients.remove(socket);
        _connectionsController.add(_clients.length);
      },
      onError: (Object e, StackTrace stackTrace) {
        _logger.e('Error in message handling: $e', stackTrace: stackTrace);
      },
    );
  }

  @override
  Stream<CurrentError> getCurrentError() {
    return _errorMessageController.stream;
  }

  @override
  Future<bool> forceDisconnect(String clientId) {
    throw UnimplementedError();
  }

  @override
  Stream<int> getConnectedClients() {
    return _connectionsController.stream;
  }

  @override
  Future<List<ErrorTracking>> showTodyErrorList() {
    throw UnimplementedError();
  }

  @override
  Future<bool> stopServer() {
    server.close();
    _clients.clear();
    _connectionsController.close();
    _errorMessageController.close();
    return Future.value(true);
  }

  @override
  Future<bool> unblockClient(String clientId) {
    throw UnimplementedError();
  }

  @override
  Stream<List<ErrorTracking>> getErrorTracking() {
    throw UnimplementedError();
  }

  // it is used to parse the current error from the json string
  CurrentError? safeParseCurrentError(String jsonString) {
    try {
      final json = Map<String, Object>.from(jsonDecode(jsonString) as Map);

      // Optional: validate minimal structure before parsing
      if (!_looksLikeCurrentError(json)) {
        debugPrint('JSON does not match CurrentError structure');
        return null;
      }

      return CurrentError.fromJson(json);
    } on Exception catch (e) {
      debugPrint('Failed to parse CurrentError: $e');

      return null;
    }
  }

  bool _looksLikeCurrentError(Map<String, Object> json) {
    return json.containsKey(CurrentErrorKeys.stackTrace) &&
        json.containsKey(CurrentErrorKeys.error) &&
        json.containsKey(CurrentErrorKeys.environment) &&
        json.containsKey(CurrentErrorKeys.date);
  }
}
