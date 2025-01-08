import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_standard/feature/todo/bloc/todo_bloc.dart';

class AddTodoDialog extends StatelessWidget {
  AddTodoDialog({super.key});

  // สร้าง controllers แบบ final เพราะ StatelessWidget จะถูกสร้างใหม่ทุกครั้งที่มีการ rebuild
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // เข้าถึง bloc โดยตรง
    final todoBloc = context.read<TodoBloc>();

    return AlertDialog(
      title: const Text('Add Todo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: _contentController,
            decoration: const InputDecoration(labelText: 'Content'),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        TextButton(
          onPressed: () {
            final title = _titleController.text;
            final content = _contentController.text;

            if (title.isNotEmpty && content.isNotEmpty) {
              todoBloc.add(AddTodo(title: title, content: content));
              Navigator.of(context).pop();
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
