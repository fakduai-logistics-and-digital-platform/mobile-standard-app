import 'package:mobile_app_standard/domain/datasource/app_datebase.dart';
import 'package:mobile_app_standard/domain/repositories/toda_repo.dart';
import 'package:get_it/get_it.dart'; // เปลี่ยนเป็นชื่อไฟล์ที่มี TodoRepository

final locator = GetIt.instance;

void setupLocator() {
  // Register AppDatabase
  locator.registerLazySingleton<AppDatabase>(() => AppDatabase());

  // Register TodoRepository
  locator.registerLazySingleton<TodoRepository>(
      () => TodoRepository(locator<AppDatabase>()));
}
