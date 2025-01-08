import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_app_standard/domain/http_client/ip.dart';
import 'package:mobile_app_standard/domain/http_client/websocket.dart';
import 'package:mobile_app_standard/locator.dart';
import 'package:mobile_app_standard/router/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  try {
    await dotenv.load(fileName: '.env.local');
    print('Loaded .env file');
  } catch (e) {
    print('Error loading .env file: $e');
  }

  connectHttpClient();
  connectWebSocket();

  runApp(
    MyApp(),
  );
}

Future<void> connectHttpClient() async {
  final ip = await IpClient().getIp();
  if (kDebugMode) {
    print('HttpClient: IP: $ip');
  }
}

Future<void> connectWebSocket() async {
  final wsClient = WebSocketClient();

  // เชื่อมต่อไปยัง WebSocket
  wsClient.connect();

  // ส่งข้อความไปยัง WebSocket
  wsClient.sendMessage('Hello, WebSocket!');

  // ฟังการตอบกลับจาก WebSocket
  wsClient.messages.listen((message) {
    print('Received: $message');
  });

  // หลังจาก 5 วินาที ปิดการเชื่อมต่อ
  Future.delayed(Duration(seconds: 5), () {
    wsClient.close();
  });
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _appRouter.config(),
    );
  }
}
