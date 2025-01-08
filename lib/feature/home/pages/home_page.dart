import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:mobile_app_standard/domain/repositories/toda_repo.dart';
import 'package:mobile_app_standard/locator.dart';
import 'package:mobile_app_standard/router/router.dart';

@RoutePage()
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              context.router
                  .push(TodoRoute(todoRepository: locator<TodoRepository>()));
            },
            child: const Text('Go to Todo Page'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(
                  context, '/user'); // ใช้ routes เพื่อไปยัง UserPage
            },
            child: const Text('Go to User Page'),
          ),
        ],
      ),
    );
  }
}
