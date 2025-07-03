import 'package:debug_app_web/core/config/central_ui.dart';
import 'package:debug_app_web/core/utils/helpers/local_db_helper.dart';
import 'package:debug_app_web/core/widgets/atoms/display/conditional_widget.dart';
import 'package:debug_app_web/features/home/domain/entity/error_tracking.dart';
import 'package:debug_app_web/features/home/presentation/cubit/server_cubit.dart';
import 'package:debug_app_web/features/home/presentation/views/error_card/error_card_view.dart';
import 'package:debug_app_web/features/home/presentation/views/side_bar/side_bar_view.dart';
import 'package:debug_app_web/features/home/presentation/views/solution_card/solution_card_view.dart';
import 'package:debug_app_web/features/home/presentation/views/top_bar/top_bar_view.dart';
import 'package:debug_app_web/features/setting/setting_homepage.dart';
import 'package:debug_app_web/features/setting/workspace/cubit/appearance_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:provider/provider.dart';

const stackTrace = '''
════════ Exception caught by widgets library ═══════════════════════════════════
The following NoSuchMethodError was thrown building MyHomePage(dirty, dependencies: [MediaQuery], state: _MyHomePageState#fa12b):
The getter 'length' was called on null.
Receiver: null
Tried calling: length

The relevant error-causing widget was:
  MyHomePage
  MyApp:file:///home/user/dev/flutter_project/lib/main.dart:10:21
''';

class HomePageView extends HookWidget {
  const HomePageView({
    required this.currentErrorData,
    required this.connectedClientCount,
    required this.isSeverRunning,
    super.key,
  });

  final ValueNotifier<ErrorTracking?> currentErrorData;
  final ValueNotifier<int> connectedClientCount;
  final ValueNotifier<bool> isSeverRunning;

  @override
  Widget build(BuildContext context) {
    final isDarkMode = useState(false);
    final port = useState(2323);

    useEffect(
      () {
        // Extract cubits before async gap
        final appearanceCubit = context.read<AppearanceCubit>();
        final serverCubit = context.read<ServerCubit>();

        () async {
          port.value = await LocalDbHelper.getPort();
          isDarkMode.value = appearanceCubit.isDarkMode;
          await serverCubit.startServerAction(
            host: '0.0.0.0',
            port: port.value,
          );
        }();
        return null;
      },
      [],
    );

    final isSideBarExpanded = useValueNotifier(true);
    final isSolutionExpanded = useState(false);

    return Scaffold(
      backgroundColor: UIConfig.appBackgroundColor,
      body: Row(
        children: [
          SideBarView(
            isExpanded: isSideBarExpanded,
          ),
          // const VerticalDivider(
          //   color: UIConfig.borderColor,
          //   width: .7,
          // ),
          Expanded(
            child: Column(
              children: [
                TopBarView(
                  connectedClientCount:
                      connectedClientCount, //  get connected client count
                  serverData: isSeverRunning, //  get server running state
                  isSideBarExpanded:
                      isSideBarExpanded.value, //  get side bar expanded state
                  startServer: () {
                    context.read<ServerCubit>().startServerAction(
                          host: '0.0.0.0',
                          port: 2323,
                        );
                  },
                  isDarkMode: isDarkMode.value,
                  lightMode: () {
                    isDarkMode.value = !isDarkMode.value;
                    context.read<AppearanceCubit>().setThemeMode(
                          isDarkMode.value ? ThemeMode.dark : ThemeMode.light,
                        );
                  },
                  settings: () {
                    showDialog<void>(
                      context: context,
                      builder: (context) => const SettingHomepage(),
                    );
                    return;
                  },
                  notifications: () {},
                  showSideBar: () {
                    isSideBarExpanded.value =
                        !isSideBarExpanded.value; //  toggle side bar expanded state
                  },
                  showSolution: () {
                    isSolutionExpanded.value =
                        !isSolutionExpanded.value; //  toggle solution expanded state
                  },
                  stopServer: () {
                    context.read<ServerCubit>().stopServerAction();
                  },
                ),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: ErrorCardView(
                          currentErrorData: currentErrorData,
                        ),
                      ),
                      ConditionalWidget(
                        condition: isSolutionExpanded.value,
                        widget: const Expanded(
                          child: SolutionCardView(),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
