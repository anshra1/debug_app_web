import 'package:debug_app_web/core/utils/helpers/local_db_helper.dart';
import 'package:debug_app_web/core/utils/helpers/network_info_plus_helper.dart';
import 'package:debug_app_web/core/widgets/atoms/display/dektop_pop_up.dart';
import 'package:debug_app_web/features/home/presentation/widget/circulat_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:network_info_plus/network_info_plus.dart';

class ConnectionDetails extends HookWidget {
  const ConnectionDetails({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ipInfo = useState<NetworkInfo?>(null);
    final port = useState<int?>(null);

    useEffect(() {
      LocalDbHelper.getPort().then((fetchedPort) {
        port.value = fetchedPort;
      });

      NetworkInfoPlusHelper.fetchNetworkInfo(
        onSuccess: (networkInfo) {
          ipInfo.value = networkInfo;
        },
        onError: (error) {},
        onPermissionDenied: () {},
      );
      return null;
    });
    return const CustomPopup(
      trigger: CircularButton(
        icon: Icons.dns_outlined,
      ),
      popupContent: Padding(
        padding: EdgeInsets.all(16),
        child: SizedBox(
          
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('This is a test popup from dektop_ui_top_bar_icon.dart'),
                // more widgets...
              ],
            ),
          ),
        ),
      ),
      
    );
    // CircularButton(
    //   icon: Icons.dns_outlined,
    //   onPressed: () {},
    // );
  }
}
