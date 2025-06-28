import 'package:debug_app_web/features/home/domain/entity/error_tracking.dart';
import 'package:debug_app_web/features/home/presentation/cubit/server_cubit.dart';
import 'package:debug_app_web/features/home/presentation/cubit/server_state.dart';
import 'package:debug_app_web/features/home/presentation/views/home_page_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class HomePage extends StatefulHookWidget {
  const HomePage({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    // context.read<ServerCubit>().startServer(
    //       StartServerParams(host: 'host', port: 80),
    //     );
  }

  @override
  Widget build(BuildContext context) {
    final errorTracingData = useValueNotifier<ErrorTracking?>(null);
    final connectedClientCount = useValueNotifier<int>(0);
    final serverData = useValueNotifier<bool>(false);

    return BlocListener<ServerCubit, ServerState>(
      listener: (context, state) {
        switch (state) {
          case ServerErrorState(:final message):
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));

          case CurrentErrorDataState(errorTracking: final currentError):
            errorTracingData.value = currentError;

          case ConnectedClientsCountState(:final connectedClient):
            connectedClientCount.value = connectedClient;

          case ServerRunningState(:final isServerRunning):
            serverData.value = isServerRunning;

          // These don't need handling
          case ServerInitialState() ||
                ServerStoppingWaitingState() ||
                ServerWaitingState():
        }
      },
      child: HomePageView(
        currentErrorData: errorTracingData,
        connectedClientCount: connectedClientCount,
        isSeverRunning: serverData,
      ),
    );
  }
}
