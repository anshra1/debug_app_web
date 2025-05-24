import 'package:debug_app_web/features/home/data/datasource/server_remote_data_source.dart';
import 'package:debug_app_web/features/home/data/repo/%20server_repo_impl.dart';
import 'package:debug_app_web/features/home/domain/repo/server_repo.dart';
import 'package:debug_app_web/features/home/domain/usecases/server_usecase.dart';
  import 'package:debug_app_web/features/home/presentation/cubit/server_cubit.dart';
import 'package:get_it/get_it.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initServer();
}

Future<void> _initServer() async {
  // Cubit
  sl
    ..registerFactory(
      () => ServerCubit(
        startServer: sl(),
        stopServer: sl(),
        getConnectedClients: sl(),
        getCurrentError: sl(),
      ),
    )
    // Use cases
    ..registerLazySingleton(() => StartServer(serverRepo: sl()))
    ..registerLazySingleton(() => StopServer(serverRepo: sl()))
    ..registerLazySingleton(() => GetConnectedClients(serverRepo: sl()))
    ..registerLazySingleton(() => GetCurrentError(serverRepo: sl()))
    // Repository
    ..registerLazySingleton<ServerRepository>(
      () => ServerRepoImpl(sl()),
    )
    // Data sources
    ..registerLazySingleton<ServerRepositoryRemoteDataSource>(
      ServerRemoteDataSourceImpl.new,
    );
}
