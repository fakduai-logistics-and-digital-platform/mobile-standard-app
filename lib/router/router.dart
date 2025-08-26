import 'package:auto_route/auto_route.dart';
import 'package:mobile_app_standard/feature/todo/pages/todo_page.dart';
import 'package:mobile_app_standard/feature/home/pages/home_page.dart';

part 'router.gr.dart'; // ไฟล์ที่สร้างโดย auto_route_generator

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          page: HomeRoute.page,
          initial: true,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
        CustomRoute(
          page: TodoRoute.page,
          transitionsBuilder: TransitionsBuilders.noTransition,
        ),
      ];
}
