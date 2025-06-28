import 'package:debug_app_web/features/home/domain/entity/error_tracking.dart';

sealed class ServerState {
  const ServerState();
}

final class ServerInitialState extends ServerState {
  const ServerInitialState();
}

final class ServerWaitingState extends ServerState {
  const ServerWaitingState();
}

final class ServerRunningState extends ServerState {
  const ServerRunningState({required this.isServerRunning});

  final bool isServerRunning;
}

final class ServerStoppingWaitingState extends ServerState {
  const ServerStoppingWaitingState();
}

final class ServerErrorState extends ServerState {
  const ServerErrorState(this.message);
  final String message;
}

final class ConnectedClientsCountState extends ServerState {
  const ConnectedClientsCountState(this.connectedClient);
  final int connectedClient;
}

final class CurrentErrorDataState extends ServerState {
  const CurrentErrorDataState(this.errorTracking);
  final ErrorTracking errorTracking;
}
