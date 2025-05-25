import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mobile_app_standard/domain/http_client/ip.dart';
import 'package:mobile_app_standard/i18n/i18n.dart';
import 'package:mobile_app_standard/locator.dart';
import 'package:mobile_app_standard/shared/styles/p_colors.dart';
import 'package:mobile_app_standard/shared/styles/p_size.dart';
import 'package:mobile_app_standard/shared/styles/p_style.dart';
import 'package:mobile_app_standard/shared/widgets/appbar/appbar_custom.dart';
import 'package:skeletonizer/skeletonizer.dart';

@RoutePage()
class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final isLoading = useState(false);
    final ipAddress = useState<String?>(null);
    final currentRouteName = context.routeData.name;
    final msg = AppLocalizations(context).homePage;
    final msgGeneral = AppLocalizations(context).general;

    Future<void> fetchIpAndShowDialog() async {
      if (isLoading.value) return;
      isLoading.value = true;
      ipAddress.value = null;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) => HookBuilder(
          builder: (context) {
            final isLoadingDialog = useState(true);
            final ip = useState<String?>(null);

            useEffect(() {
              Future.microtask(() async {
                final result = await locator<IpClient>().getIp();
                ip.value = result;
                isLoadingDialog.value = false;
              });
              return null;
            }, []);

            return AlertDialog(
              title: const Text('IP'),
              backgroundColor: Colors.white,
              content: Skeletonizer(
                enabled: isLoadingDialog.value,
                child: Text(ip.value ?? '255.255.255.255',
                    style: const TextStyle(fontSize: PText.textBase)),
              ),
              actions: [
                TextButton(
                  style: PStyle.btnSecondary,
                  onPressed: () => Navigator.of(dialogContext).pop(),
                  child: Text(msgGeneral.close),
                ),
              ],
            );
          },
        ),
      );

      final ip = await locator<IpClient>().getIp();
      isLoading.value = false;
      ipAddress.value = ip;
    }

    return Scaffold(
      appBar: AppBarCustom(currentRouteName: currentRouteName),
      backgroundColor: PColor.backgroundColor,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              msg.text_welcome('Fakduai APP'),
              style: const TextStyle(
                fontSize: PText.text2xl,
              ),
            ),
            const SizedBox(height: 8),
            SizedBox(
              width: 400,
              child: TextButton(
                style: PStyle.btnPrimary,
                onPressed: fetchIpAndShowDialog,
                child: isLoading.value
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : Text(msg.btn_check_ip),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
