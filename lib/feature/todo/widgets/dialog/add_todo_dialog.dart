import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_standard/feature/todo/bloc/todo_bloc.dart';
import 'package:mobile_app_standard/i18n/i18n.dart';
import 'package:mobile_app_standard/shared/styles/p_colors.dart';
import 'package:mobile_app_standard/shared/styles/p_size.dart';
import 'package:mobile_app_standard/shared/styles/p_style.dart';
import 'package:mobile_app_standard/shared/widgets/toasts/toast_helper.dart';

class AddTodoDialog extends StatelessWidget {
  AddTodoDialog({super.key});

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final todoBloc = context.read<TodoBloc>();
    final msg = AppLocalizations(context).todoPage;
    final msgGeneral = AppLocalizations(context).general;
    return AlertDialog(
      title: Row(children: [
        Icon(Icons.add, color: PColor.primaryColor, size: PText.text2xl),
        Text(msg.title_add_todo, style: TextStyle(fontSize: PText.textXl))
      ]),
      backgroundColor: Colors.white,
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: msg.label_title),
            ),
            TextField(
              maxLength: 32,
              controller: _contentController,
              decoration: InputDecoration(labelText: msg.label_content),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          style: PStyle.btnSecondary,
          onPressed: () => Navigator.of(context).pop(),
          child: Text(msgGeneral.cancel),
        ),
        ValueListenableBuilder<TextEditingValue>(
          valueListenable: _titleController,
          builder: (context, titleValue, child) {
            return ValueListenableBuilder<TextEditingValue>(
              valueListenable: _contentController,
              builder: (context, contentValue, child) {
                final isEnabled = titleValue.text.isNotEmpty &&
                    (contentValue.text.isNotEmpty &&
                        contentValue.text.length >= 6);
                return TextButton(
                  style: PStyle.btnPrimary,
                  onPressed: isEnabled
                      ? () {
                          todoBloc.add(AddTodo(
                            title: titleValue.text,
                            content: contentValue.text,
                          ));
                          Navigator.of(context).pop();
                          showSuccessToast(
                              context: context,
                              title: msg.text_added,
                              description: msg.text_added_success);
                        }
                      : null,
                  child: Text(msgGeneral.add),
                );
              },
            );
          },
        ),
      ],
    );
  }
}
