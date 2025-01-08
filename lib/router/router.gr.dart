// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    HomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HomePage(),
      );
    },
    TodoRoute.name: (routeData) {
      final args = routeData.argsAs<TodoRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: TodoPage(
          key: args.key,
          todoRepository: args.todoRepository,
        ),
      );
    },
  };
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [TodoPage]
class TodoRoute extends PageRouteInfo<TodoRouteArgs> {
  TodoRoute({
    Key? key,
    required TodoRepository todoRepository,
    List<PageRouteInfo>? children,
  }) : super(
          TodoRoute.name,
          args: TodoRouteArgs(
            key: key,
            todoRepository: todoRepository,
          ),
          initialChildren: children,
        );

  static const String name = 'TodoRoute';

  static const PageInfo<TodoRouteArgs> page = PageInfo<TodoRouteArgs>(name);
}

class TodoRouteArgs {
  const TodoRouteArgs({
    this.key,
    required this.todoRepository,
  });

  final Key? key;

  final TodoRepository todoRepository;

  @override
  String toString() {
    return 'TodoRouteArgs{key: $key, todoRepository: $todoRepository}';
  }
}
