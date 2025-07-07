import 'package:debug_app_web/core/services/loading_toast_service.dart';
import 'package:debug_app_web/core/services/toast_service.dart';
import 'package:debug_app_web/features/home/data/datasource/remote_data_source/server_rds.dart';
import 'package:debug_app_web/features/home/data/repo/%20server_repo_impl.dart';
import 'package:debug_app_web/features/home/domain/repo/server_repo.dart';
import 'package:debug_app_web/features/home/domain/usecases/server_usecase.dart';
import 'package:debug_app_web/features/home/presentation/cubit/server_cubit.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:toastification/toastification.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initCore();
  await _initServer();
}

Future<void> _initCore() async {
  // Create single Toastification instance
  final toastification = Toastification();

  sl
    ..registerLazySingleton(() => toastification) // Register the instance
    ..registerLazySingleton(
      () => ValueNotifier<(String message, double progress)>(('', 0.0)),
      dispose: (notifier) => notifier.dispose(), // Ensure proper disposal
    )
    ..registerLazySingleton(
      () => LoadingToastService(
        toastification: sl(),
        dataNotifier: sl(),
      ),
    )
    ..registerLazySingleton(() => ToastService(sl())); // Use sl() to get toastification
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
