import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:debug_app_web/core/error/error_mapper.dart' show ErrorMapper;
import 'package:debug_app_web/core/error/failure.dart';
import 'package:debug_app_web/core/typesdef/typedefs.dart';
import 'package:debug_app_web/features/home/data/datasource/server_remote_data_source.dart';
import 'package:debug_app_web/features/home/domain/entity/current_error.dart';
import 'package:debug_app_web/features/home/domain/entity/error_tracking.dart';
import 'package:debug_app_web/features/home/domain/repo/server_repo.dart';

class ServerRepoImpl implements ServerRepository {
  ServerRepoImpl(this.serverRepo);

  final ServerRepositoryRemoteDataSource serverRepo;

  @override
  ResultFuture<bool> startServer({required String host, required int port}) async {
    try {
      final result = await serverRepo.startServer(host: host, port: port);
      return Right(result); // Return success
    } on Exception catch (e) {
      return Left(ErrorMapper.mapErrorToFailure(e)); // Return failure
    }
  }

  @override
  ResultFuture<bool> stopServer() async {
    try {
      final result = await serverRepo.stopServer();
      return Right(result); // Return success
    } on Exception catch (e) {
      return Left(ErrorMapper.mapErrorToFailure(e)); // Return failure
    }
  }

  @override
  ResultStream<int> getConnectedClients() {
    return serverRepo.getConnectedClients().transform(
          StreamTransformer<int, Either<Failure, int>>.fromHandlers(
            handleData: (data, sink) {
              sink.add(Right(data));
            },
            handleError: (error, stackTrace, sink) {
              sink.add(Left(ErrorMapper.mapErrorToFailure(error)));
            },
          ),
        );
  }

  @override
  ResultStream<CurrentError> getCurrentError() {
    return serverRepo.getCurrentError().transform(
          StreamTransformer<CurrentError, Either<Failure, CurrentError>>.fromHandlers(
            handleData: (data, sink) {
              sink.add(Right(data));
            },
            handleError: (error, stackTrace, sink) {
              sink.add(Left(ErrorMapper.mapErrorToFailure(error)));
            },
          ),
        );
  }

  @override
  ResultFuture<List<ErrorTracking>> showTodyErrorList() async {
    try {
      final result = await serverRepo.showTodyErrorList();
      return Right(result); // Return success
    } on Exception catch (e) {
      return Left(ErrorMapper.mapErrorToFailure(e)); // Return failure
    }
  }

  @override
  ResultFuture<bool> unblockClient(String clientId) async {
    try {
      final result = await serverRepo.unblockClient(clientId);
      return Right(result); // Return success
    } on Exception catch (e) {
      return Left(ErrorMapper.mapErrorToFailure(e)); // Return failure
    }
  }

  @override
  ResultFuture<bool> forceDisconnect(String clientId) async {
    try {
      final result = await serverRepo.forceDisconnect(clientId);
      return Right(result); // Return success
    } on Exception catch (e) {
      return Left(ErrorMapper.mapErrorToFailure(e)); // Return failure
    }
  }

  @override
  ResultStream<List<ErrorTracking>> getErrorTracking() async* {}
}
