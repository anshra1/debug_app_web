import 'package:debug_app_web/core/utils/typesdef/typedefs.dart';
import 'package:debug_app_web/core/utils/usecases/usecases.dart';
import 'package:debug_app_web/features/home/domain/entity/error_tracking.dart';
import 'package:debug_app_web/features/home/domain/repo/server_repo.dart';

class StartServer extends FutureUseCaseWithParams<bool, StartServerParams> {
  StartServer({required this.serverRepo});

  final ServerRepository serverRepo;

  @override
  ResultFuture<bool> call(StartServerParams params) {
    return serverRepo.startServer(host: params.host, port: params.port);
  }
}

class StartServerParams {
  StartServerParams({required this.host, required this.port});
  final String host;
  final int port;
}

class StopServer extends FutureUseCaseWithoutParams<bool> {
  StopServer({
    required this.serverRepo,
  });

  final ServerRepository serverRepo;

  @override
  ResultFuture<bool> call() {
    return serverRepo.stopServer();
  }
}

class ShowTodayErrorList extends FutureUseCaseWithoutParams<List<ErrorTracking>> {
  ShowTodayErrorList({required this.serverRepo});

  final ServerRepository serverRepo;

  @override
  ResultFuture<List<ErrorTracking>> call() {
    return serverRepo.showTodyErrorList();
  }
}

class UnblockClient extends FutureUseCaseWithParams<bool, String> {
  UnblockClient({
    required this.serverRepo,
  });

  final ServerRepository serverRepo;

  @override
  ResultFuture<bool> call(String clientId) {
    return serverRepo.unblockClient(clientId);
  }
}

class ForceDisconnect extends FutureUseCaseWithParams<bool, String> {
  ForceDisconnect({
    required this.serverRepo,
  });

  final ServerRepository serverRepo;

  @override
  ResultFuture<bool> call(String clientId) {
    return serverRepo.forceDisconnect(clientId);
  }
}

class GetConnectedClients extends StreamUseCaseWithoutParam<int> {
  GetConnectedClients({
    required this.serverRepo,
  });

  final ServerRepository serverRepo;

  @override
  ResultStream<int> call() {
    return serverRepo.getConnectedClients();
  }
}

class GetCurrentError extends StreamUseCaseWithoutParam<ErrorTracking> {
  GetCurrentError({
    required this.serverRepo,
  });

  final ServerRepository serverRepo;

  @override
  ResultStream<ErrorTracking> call() {
    return serverRepo.getCurrentError();
  }
}

class GetErrorTracking extends StreamUseCaseWithoutParam<List<ErrorTracking>> {
  GetErrorTracking({
    required this.serverRepo,
  });

  final ServerRepository serverRepo;

  @override
  ResultStream<List<ErrorTracking>> call() {
    return serverRepo.getErrorTracking();
  }
}
