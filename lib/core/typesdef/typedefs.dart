
import 'package:dartz/dartz.dart';
import 'package:debug_app_web/core/error/failure.dart';


typedef ResultFuture<T> = Future<Either<Failure, T>>;
typedef ResultStream<T> = Stream<Either<Failure, T>>;
typedef DataMap = Map<String, dynamic>;

// server
typedef ClientInfo = String;


