import 'package:debug_app_web/features/home/domain/entity/current_error.dart';
import 'package:equatable/equatable.dart';

/// Base state for server operations
abstract class ServerState extends Equatable {
  const ServerState();

  @override
  List<Object?> get props => [];
}

/// Initial state when the server cubit is first created
class ServerInitialState extends ServerState {
  const ServerInitialState();
}

/// Waiting state when server is in the process of starting
class ServerWaitingState extends ServerState {
  const ServerWaitingState();
}

/// Data state containing server running information
class ServerDataState extends ServerState {
  const ServerDataState({
    required this.host,
    required this.port,
  });
  final String host;
  final int port;

  @override
  List<Object?> get props => [host, port];
}

/// Waiting state when server is in the process of stopping
class ServerStoppingWaitingState extends ServerState {
  const ServerStoppingWaitingState();
}

/// Idle state when server is stopped and waiting for interaction
class ServerIdleState extends ServerState {
  const ServerIdleState();
}

/// Error state when server operations fail
class ServerErrorState extends ServerState {
  const ServerErrorState(this.message);
  final String message;

  @override
  List<Object?> get props => [message];
}

/// Data state containing connected clients count
class ConnectedClientsDataState extends ServerState {
  const ConnectedClientsDataState(this.connectedClient);
  final int connectedClient;

  @override
  List<Object?> get props => [connectedClient];
}

/// Data state containing current error information
class CurrentErrorDataState extends ServerState {
  const CurrentErrorDataState(this.currentError);
  final CurrentError currentError;

  @override
  List<Object?> get props => [currentError];
}
