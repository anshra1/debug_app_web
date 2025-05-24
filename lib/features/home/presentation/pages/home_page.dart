import 'package:debug_app_web/features/home/domain/entity/current_error.dart';
import 'package:debug_app_web/features/home/domain/usecases/server_usecase.dart';
import 'package:debug_app_web/features/home/presentation/cubit/server_cubit.dart';
import 'package:debug_app_web/features/home/presentation/cubit/server_state.dart';
import 'package:debug_app_web/features/home/presentation/pages/error_container.dart';
import 'package:debug_app_web/features/home/presentation/pages/side_bar.dart';
import 'package:debug_app_web/features/home/presentation/pages/top_bar.dart';
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
    context.read<ServerCubit>().startServer(
          StartServerParams(host: 'host', port: 80),
        );
  }

  @override
  Widget build(BuildContext context) {
    final isSideBarVisible = useState<bool>(true);
    final currentError = useState<CurrentError?>(null);
    final conncectedClientCount = useState<int>(0);

    return BlocConsumer<ServerCubit, ServerState>(
      listenWhen: (previous, current) {
        if (current is ServerErrorState) {
          return true;
        }
        return false;
      },
      listener: (context, state) {
        if (state is ServerErrorState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      buildWhen: (previous, current) {
        if (current is CurrentErrorDataState || current is ConnectedClientsDataState) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (state is CurrentErrorDataState) {
            currentError.value = state.currentError;
          } else if (state is ConnectedClientsDataState) {
            conncectedClientCount.value = state.connectedClient;
          }
        });

        return Scaffold(
          body: Column(
            children: [
              TopBar(
                totalErrors: conncectedClientCount.value,
                showSideBarOnPressed: () {
                  isSideBarVisible.value = !isSideBarVisible.value;
                },
                startServerOnPressed: () {
                  context.read<ServerCubit>().startServer(
                        StartServerParams(host: '0.0.0.0', port: 2100),
                      );
                },
                stopServerOnPressed: () {},
              ),
              const Divider(
                height: 1,
                color: Colors.grey,
              ),
              Expanded(
                child: Row(
                  children: [
                    if (isSideBarVisible.value) ...[
                      const SideBarContainer(),
                      const VerticalDivider(
                        width: 1,
                        color: Colors.black,
                      ),
                    ],
                    Expanded(
                      flex: 2,
                      child: ErrorContainer(currentError: currentError.value),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
