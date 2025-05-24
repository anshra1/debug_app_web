// ignore_for_file: one_member_abstracts, document_ignores

import 'package:debug_app_web/core/typesdef/typedefs.dart';

abstract class FutureUseCaseWithParams<ResultType, InputParams> {
  const FutureUseCaseWithParams();

  ResultFuture<ResultType> call(InputParams params);
}

abstract class FutureUseCaseWithoutParams<ResultType> {
  const FutureUseCaseWithoutParams();

  ResultFuture<ResultType> call();
}

abstract class StreamUseCaseWithParams<ResultType, InputParams> {
  const StreamUseCaseWithParams();

  ResultStream<ResultType> call(InputParams params);
}

abstract class StreamUseCaseWithoutParam<ResultType> {
  const StreamUseCaseWithoutParam();

  ResultStream<ResultType> call();
}
