import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:mobile_app_standard/domain/http_client/websocket.dart';
import 'package:mobile_app_standard/feature/home/bloc/websocket/websocket_bloc.dart';
import 'package:mobile_app_standard/feature/todo/bloc/todo_bloc.dart';
import 'package:mobile_app_standard/locator.dart';
import 'package:mobile_app_standard/router/router.dart';
import 'package:mobile_app_standard/shared/styles/p_colors.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  try {
    await dotenv.load(fileName: '.env');
    print('Loaded .env file');
  } catch (e) {
    print('Error loading .env file: $e');
  }
  // connectWebSocket();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider<TodoBloc>(
        create: (context) => locator<TodoBloc>(),
      ),
      BlocProvider<WebsocketBloc>(
        create: (context) => locator<WebsocketBloc>(),
      )
      // add more providers
    ],
    child: MyApp(),
  ));
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

  // Future.delayed(Duration(seconds: 5), () {
  //   wsClient.close();
  // });
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: PColor.primaryColor),
        useMaterial3: true,
      ),
      routerConfig: _appRouter.config(),
    );
  }
}
