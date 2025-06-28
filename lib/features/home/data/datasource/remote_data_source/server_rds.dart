import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:debug_app_web/core/constants/keys.dart';
import 'package:debug_app_web/core/enum/error_category.dart';
import 'package:debug_app_web/core/enum/error_color_category.dart';
import 'package:debug_app_web/features/home/domain/entity/current_error.dart';
import 'package:debug_app_web/features/home/domain/entity/error_tracking.dart';
import 'package:flutter/material.dart' show debugPrint;
import 'package:logger/logger.dart';
import 'package:uuid/uuid.dart';

abstract class ServerRepositoryRemoteDataSource {
  Future<bool> startServer({required String host, required int port});

  Future<bool> stopServer();

  Future<List<ErrorTracking>> showTodyErrorList();

  Future<bool> unblockClient(String clientId);

  Future<bool> forceDisconnect(String clientId);

  Stream<int> getConnectedClients();

  Stream<ErrorTracking> getCurrentError();

  Stream<List<ErrorTracking>> getErrorTracking();
}

List<ErrorTracking> errorTrackingList = [];

class SocketClient {
  SocketClient({
    required this.socket,
    required this.id,
  });

  final WebSocket socket;
  final String id;
}

List<SocketClient> socketClients = [];

class ServerRemoteDataSourceImpl extends ServerRepositoryRemoteDataSource {
  final _logger = Logger();

  final List<WebSocket> _clients = [];
  late HttpServer server;

  final _connectionsController = StreamController<int>.broadcast();
  final _errorMessageController = StreamController<ErrorTracking>.broadcast();

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
      server = await HttpServer.bind(host, port);

      // setting the server to running
      _isServerRunning = true;

      // listening to the server
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
        if (_isServerRunning) {
          _logger.i('A client disconnected, but server is still running');
        }
      },
      onError: (Object e, StackTrace stackTrace) {
        _isServerRunning = false;
        _logger.e('Error in server listening: $e', stackTrace: stackTrace);
      },
    );
  }

  void _addClient(WebSocket socket) {
    _clients.add(socket);
    _connectionsController.add(_clients.length);
  }

  void _handleClientAndMessages(WebSocket socket) {
    // adding the socket to the list of clients
    socketClients.add(SocketClient(socket: socket, id: const Uuid().v4()));

    //
    socket.listen(
      (message) {
        final currentError = safeParseCurrentError(message as String);

        // check if the message is a CurrentError
        if (currentError != null) {
          final errorTracking = ErrorTracking(
            id: const Uuid().v4(),
            currentError: currentError,
            solutions: [],
            errorCategory: ErrorCategory.error,
            errorTags: [],
            fingerPrintHashing: '',
            dates: [],
            errorColorCategory: ErrorColorCategory.ui,
          );
          errorTrackingList.add(errorTracking);
          _errorMessageController.add(errorTracking);
        } else {
          _logger.e('Failed to parse CurrentError. Raw message: $message');
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
  Stream<ErrorTracking> getCurrentError() {
    return _errorMessageController.stream;
  }

  @override
  Future<bool> forceDisconnect(String clientId) {
    try {
      // find the client by id
      final client = socketClients.firstWhere((client) => client.id == clientId);

      // close the socket
      client.socket.close();

      // remove the client from the list of clients
      socketClients.remove(client);

      return Future.value(true);
    } on Exception catch (e) {
      _logger.e('Failed to force disconnect client: $e');
      return Future.value(false);
    }
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
    _isServerRunning = false;
    server.close();
    _clients.clear();
    _connectionsController.close();
    _errorMessageController.close();
    _logger.i('Server has been stopped.');
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
      final json = jsonDecode(jsonString);
      if (json is! Map<String, dynamic>) {
        debugPrint('Decoded JSON is not a Map. Input: $jsonString');
        _logger.e('safeParseCurrentError failed: Decoded JSON is not a Map');
        return null;
      }

      if (!_looksLikeCurrentError(json)) {
        debugPrint('JSON does not match CurrentError structure. JSON: $json');
        _logger.e(
          'safeParseCurrentError failed: JSON does not match CurrentError structure',
        );
        return null;
      }

      return CurrentError.fromJson(json);
    } on Exception catch (e, stack) {
      debugPrint('Failed to parse CurrentError: $e. Input: $jsonString');
      _logger.e(
        'safeParseCurrentError failed: Exception during parsing',
        error: e,
        stackTrace: stack,
      );
      return null;
    }
  }

  bool _looksLikeCurrentError(Map<String, dynamic> json) {
    return json.containsKey(CurrentErrorKeys.error) &&
        json[CurrentErrorKeys.platform] is String &&
        json[CurrentErrorKeys.stackTrace] is String? &&
        json[CurrentErrorKeys.error] is String;
  }
}





