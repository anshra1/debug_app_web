import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:debug_app_web/core/utils/helpers/connecttivity.dart';
import 'package:debug_app_web/core/utils/helpers/local_db_helper.dart';
import 'package:debug_app_web/core/utils/helpers/network_info_plus_helper.dart';
import 'package:debug_app_web/core/widgets/atoms/buttons/text_disply_with_label.dart';
import 'package:debug_app_web/core/widgets/atoms/buttons/text_field_button_with_label.dart';
import 'package:debug_app_web/core/widgets/atoms/display/dektop_pop_up.dart';
import 'package:debug_app_web/features/home/presentation/widget/circulat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class ServerDetailsIconWidget extends StatefulWidget {
  const ServerDetailsIconWidget({super.key});

  @override
  State<ServerDetailsIconWidget> createState() => _ServerDetailsIconWidgetState();
}

class _ServerDetailsIconWidgetState extends State<ServerDetailsIconWidget> {
  final GlobalKey _contentKey = GlobalKey();
  Size? contentSize;

  @override
  Widget build(BuildContext context) {
    return CustomPopup(
      trigger: const CircularButton(icon: Icons.dns_outlined),
      backgroundColor: Colors.grey[900],
      popupContent: Padding(
        padding: const EdgeInsets.all(16),
        child: HookBuilder(
          builder: (context) {
            final ipAddress = useState<String?>(null);
            final port = useState<String?>(null);
            final connectivity = useState<ConnectivityResult?>(null);

            Future<void> loadEverything() async {
              connectivity.value = await ConnectivityHelper.getCurrentConnectivityType();

              if (connectivity.value == ConnectivityResult.wifi ||
                  connectivity.value == ConnectivityResult.ethernet) {
                    //
                await NetworkInfoPlusHelper.fetchNetworkInfo(
                  onSuccess: (info) async => ipAddress.value = await info.getWifiIP(),
                  onError: (_) => ipAddress.value = 'Error',
                  onPermissionDenied: () => ipAddress.value = 'Permission Denied',
                );
              } else {
                ipAddress.value = '127.0.0.1';
              }

              final portStored = await LocalDbHelper.getPort();
              port.value = portStored.toString();
            }

            useEffect(
              () {
                loadEverything();
                return null;
              },
              [],
            );

            final isLoading = ipAddress.value == null || port.value == null;

            // Capture content size after it's built
            WidgetsBinding.instance.addPostFrameCallback((_) {
              final ctx = _contentKey.currentContext;
              if (ctx != null) {
                final newSize = ctx.size;
                if (newSize != contentSize) {
                  setState(() => contentSize = newSize);
                }
              }
            });

            return Stack(
              children: [
                // 👇 Real content
                Column(
                  key: _contentKey,
                  children: [
                    TextDisplayWithLabel(
                      labelText: 'IP ADDRESS',
                      tooltipText: 'IP ADDRESS',
                      config: TextDisplayWithLabelConfig.defaultConfig(),
                      getText: () => ipAddress.value ?? '',
                    ),
                    const Gap(16),
                    TextFieldButtonWithLabel(
                      startingText: port.value ?? '',
                      config: TextFieldButtonWithLabelConfig.defaultConfig(),
                      onTextSubmitted: (value) async {
                        final parsed = int.tryParse(value);
                        if (parsed != null && parsed >= 1024 && parsed <= 65535) {
                          await LocalDbHelper.setPort(parsed);
                          port.value = parsed.toString();
                        }
                      },
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(5),
                      ],
                      iconData: Icons.edit,
                      labelText: 'PORT',
                      validators: ValidationBuilder()
                          .maxLength(5)
                          .minLength(4)
                          .required()
                          .build(),
                    ),
                  ],
                ),

                // 👇 Size-matched shimmer overlay
                if (isLoading && contentSize != null)
                  Positioned.fill(
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey.withOpacity(0.2),
                      highlightColor: Colors.grey.withOpacity(0.4),
                      period: const Duration(milliseconds: 1200),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Container(
                          width: contentSize?.width ?? double.infinity,
                          height: contentSize?.height ?? double.infinity,
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF2C2C2E), // learn key
                                Color(0xFF3A3A3C),
                                Color(0xFF2C2C2E),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _LoadingShimmer extends StatelessWidget {
  const _LoadingShimmer();

  @override
  Widget build(BuildContext context) {
    final baseColor = Colors.grey.shade800;
    final highlightColor = Colors.grey.shade600;

    return Column(
      children: [
        Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        const Gap(16),
        Shimmer.fromColors(
          baseColor: baseColor,
          highlightColor: highlightColor,
          child: Container(
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              color: baseColor,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ],
    );
  }
}
