import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_standard/feature/todo/bloc/todo_bloc.dart';
import 'package:mobile_app_standard/feature/todo/model/todo_model.dart';
import 'package:mobile_app_standard/feature/todo/widgets/dialog/add_todo_dialog.dart';
import 'package:mobile_app_standard/shared/styles/p_colors.dart';
import 'package:mobile_app_standard/shared/styles/p_size.dart';
import 'package:mobile_app_standard/shared/widgets/appbar/appbar_custom.dart';

@RoutePage()
class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRouteName = context.routeData.name;
    return Scaffold(
      appBar: AppBarCustom(currentRouteName: currentRouteName),
      backgroundColor: PColor.backgroundColor,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
                mainAxisAlignment: MainAxisAlignment.start,
                spacing: 8,
                children: [
                  Icon(Icons.list_alt_outlined, color: PColor.primaryColor),
                  Text("Todo List", style: TextStyle(fontSize: PText.textXl)),
                ]),
            Expanded(
              child: BlocBuilder<TodoBloc, TodoState>(
                builder: (todoContext, state) {
                  final List<TodoModel> items = [];
                  if (state is TodoLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (state is TodoLoaded) {
                    items.addAll(state.todos);
                  }

                  if (items.isEmpty) {
                    return const Center(child: Text('No todos available.'));
                  }
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: ListTile(
                          title: Text(items[index].title),
                          subtitle: Text(items[index].content),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            color: PColor.errorColor,
                            onPressed: () {
                              context
                                  .read<TodoBloc>()
                                  .add(DeleteTodo(id: items[index].id));
                            },
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Builder(
          builder: (context) => FloatingActionButton(
                backgroundColor: PColor.primaryColor,
                foregroundColor: Colors.white,
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (dialogContext) => BlocProvider.value(
                      // ส่งต่อ bloc instance จาก parent
                      value: context.read<TodoBloc>(),
                      child: AddTodoDialog(),
                    ),
                  );
                },
                child: const Icon(Icons.add),
              )),
    );
  }
}
