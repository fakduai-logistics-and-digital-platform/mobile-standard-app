import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_standard/domain/repositories/toda_repo.dart';
import 'package:mobile_app_standard/feature/todo/bloc/todo_bloc.dart';
import 'package:mobile_app_standard/feature/todo/pages/todo_page.dart';
import 'package:mobile_app_standard/feature/home/pages/home_page.dart';
import 'package:mobile_app_standard/locator.dart';

part 'router.gr.dart'; // ไฟล์ที่สร้างโดย auto_route_generator

@AutoRouterConfig()
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(
          page: TodoRoute.page,
          guards: [TodoBlocProvider()], // สร้างอินสแตนซ์ของ TodoBlocProvider
        ),
      ];
}

class TodoBlocProvider extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {
    final todoRepository = locator<TodoRepository>();

    // สร้าง MultiBlocProvider และกำหนดให้เป็นหน้าใหม่
    final todoPage = MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              TodoBloc(todoRepository: todoRepository)..add(LoadTodos()),
        ),
        //??
        // BlocProvider(
        //   create: (context) =>
        //       UserBloc(userRepository: userRepository)..add(LoadUsers()),
        // ),
        //??
      ],
      child: TodoPage(todoRepository: todoRepository),
    );

    // ส่งค่า true เพื่อระบุว่าการนำทางควรดำเนินการต่อ
    resolver.next(true);
  }
}
