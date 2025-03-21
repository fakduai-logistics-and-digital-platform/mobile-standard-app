import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_standard/domain/http_client/ip.dart';
import 'package:mobile_app_standard/locator.dart';
import 'package:mobile_app_standard/shared/styles/p_colors.dart';
import 'package:mobile_app_standard/shared/styles/p_size.dart';
import 'package:mobile_app_standard/shared/styles/p_style.dart';
import 'package:mobile_app_standard/shared/widgets/appbar/appbar_custom.dart';

@RoutePage()
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final currentRouteName = context.routeData.name;
    return Scaffold(
      appBar: AppBarCustom(currentRouteName: currentRouteName),
      backgroundColor: PColor.backgroundColor,
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          spacing: 8,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome to Fakduai App',
              style: TextStyle(
                fontSize: PText.text2xl,
              ),
            ),
            SizedBox(
              width: 400,
              child: TextButton(
                style: PStyle.btnPrimary,
                onPressed: () async {
                  setState(() {
                    _isLoading = true; // เริ่มโหลด
                  });
                  final ip = await _connectHttpClient();
                  if (!context.mounted) return;
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('IP'),
                      content: Text(ip),
                      actions: [
                        TextButton(
                          style: PStyle.btnSecondary,
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Close'),
                        ),
                      ],
                    ),
                  );
                  setState(() {
                    _isLoading = false;
                  });
                },
                child: _isLoading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                    : const Text('Check IP'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<String> _connectHttpClient() async {
    final ip = await locator<IpClient>().getIp();
    return ip;
  }
}
