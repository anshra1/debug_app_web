import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:debug_app_web/core/error/failure.dart';
import 'package:debug_app_web/features/home/domain/entity/error_tracking.dart';
import 'package:debug_app_web/features/home/domain/usecases/server_usecase.dart';
import 'package:debug_app_web/features/home/presentation/cubit/server_state.dart';

/// Cubit responsible for managing server operations and state
class ServerCubit extends Cubit<ServerState> {
  ServerCubit({
    required this.startServer,
    required this.stopServer,
    required this.getConnectedClients,
    required this.getCurrentError,
  }) : super(const ServerInitialState()) {
    _setupStreams();
  }

  final StartServer startServer;
  final StopServer stopServer;
  final GetConnectedClients getConnectedClients;
  final GetCurrentError getCurrentError;

  StreamSubscription<Either<Failure, int>>? _connectedClientsSubscription;
  StreamSubscription<Either<Failure, ErrorTracking>>? _currentErrorSubscription;

  /// Sets up streams for connected clients and current error monitoring
  void _setupStreams() {
    _connectedClientsSubscription = getConnectedClients().listen(
      (either) {
        either.fold(
          (failure) => emit(ServerErrorState(failure.message)),
          (count) => emit(ConnectedClientsCountState(count)),
        );
      },
      onError: (Object error, StackTrace stackTrace) {
        emit(ServerErrorState(error.toString()));
      },
      onDone: () {
        _connectedClientsSubscription?.cancel();
      },
    );

    _currentErrorSubscription = getCurrentError().listen(
      (either) {
        either.fold(
          (failure) => emit(ServerErrorState(failure.message)),
          (error) {
            //  DebugLogger.instance.info('Current error: $error');
            emit(CurrentErrorDataState(error));
          },
        );
      },
      onError: (Object error, StackTrace stackTrace) {
        emit(ServerErrorState(error.toString()));
      },
      onDone: () {
        _currentErrorSubscription?.cancel();
      },
    );
  }

  /// Starts the server with specified host and port
  Future<void> startServerAction({required String host, required int port}) async {
    emit(const ServerWaitingState());
    final result = await startServer(StartServerParams(host: host, port: port));
    result.fold(
      (failure) => emit(ServerErrorState(failure.message)),
      (success) => emit(ServerRunningState(isServerRunning: success)),
    );
  }

  /// Stops the running server
  Future<void> stopServerAction() async {
    emit(const ServerStoppingWaitingState());
    final result = await stopServer();
    result.fold(
      (failure) => emit(ServerErrorState(failure.message)),
      (success) => emit(const ServerRunningState(isServerRunning: false)),
    );
  }

  @override
  Future<void> close() {
    _connectedClientsSubscription?.cancel();
    _currentErrorSubscription?.cancel();
    return super.close();
  }
}
