import 'package:debug_app_web/core/typesdef/typedefs.dart';
import 'package:debug_app_web/features/home/domain/entity/current_error.dart';
import 'package:debug_app_web/features/home/domain/entity/error_tracking.dart';

abstract class ServerRepository {
  ResultFuture<bool> startServer({required String host, required int port});

  ResultFuture<bool> stopServer();

  ResultFuture<List<ErrorTracking>> showTodyErrorList();

  ResultFuture<bool> unblockClient(String clientId);

  ResultFuture<bool> forceDisconnect(String clientId);

  ResultStream<int> getConnectedClients();

  ResultStream<CurrentError> getCurrentError();

  ResultStream<List<ErrorTracking>> getErrorTracking();
}
