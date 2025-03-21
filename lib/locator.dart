import 'package:mobile_app_standard/domain/datasource/app_datebase.dart';
import 'package:mobile_app_standard/domain/http_client/ip.dart';
import 'package:mobile_app_standard/domain/http_client/websocket.dart';
import 'package:mobile_app_standard/domain/repositories/todo_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:mobile_app_standard/feature/home/bloc/websocket/websocket_bloc.dart';
import 'package:mobile_app_standard/feature/todo/bloc/todo_bloc.dart'; // เปลี่ยนเป็นชื่อไฟล์ที่มี TodoRepository

final locator = GetIt.instance;

void setupLocator() {
  // Register AppDatabase
  locator.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // Register Repository
  locator.registerLazySingleton<TodoRepository>(
      () => TodoRepository(locator<AppDatabase>()));

  // Register HttpClient
  locator.registerLazySingleton<IpClient>(() => IpClient());

  // Register WebSocketClient
  locator.registerLazySingleton<WebSocketClient>(() => WebSocketClient());

  // Register Bloc
  locator.registerLazySingleton<TodoBloc>(
      () => TodoBloc(todoRepository: locator<TodoRepository>()));
  locator.registerLazySingleton<WebsocketBloc>(() => WebsocketBloc());
}
