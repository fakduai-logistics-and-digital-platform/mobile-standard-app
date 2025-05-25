import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:mobile_app_standard/feature/todo/bloc/todo_bloc.dart';
import 'package:mobile_app_standard/feature/todo/model/todo_model.dart';
import 'package:mobile_app_standard/feature/todo/widgets/dialog/add_todo_dialog.dart';
import 'package:mobile_app_standard/i18n/i18n.dart';
import 'package:mobile_app_standard/shared/styles/p_colors.dart';
import 'package:mobile_app_standard/shared/styles/p_size.dart';
import 'package:mobile_app_standard/shared/widgets/appbar/appbar_custom.dart';

@RoutePage()
class TodoPage extends HookWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRouteName = context.routeData.name;
    final msg = AppLocalizations(context).todoPage;

    final displayedItems = useState(8);
    final scrollController = useScrollController();

    useEffect(() {
      void onScroll() {
        if (scrollController.position.extentAfter < 200) {
          displayedItems.value += 3;
        }
      }

      scrollController.addListener(onScroll);
      return () => scrollController.removeListener(onScroll);
    }, [scrollController]);

    return Scaffold(
      appBar: AppBarCustom(currentRouteName: currentRouteName),
      backgroundColor: PColor.backgroundColor,
      body: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Icon(Icons.list_alt_outlined, color: PColor.primaryColor),
                const SizedBox(width: 8),
                Text(
                  msg.title_todo,
                  style: TextStyle(fontSize: PText.textXl),
                ),
              ],
            ),
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
                    return Center(child: Text(msg.text_no_todo));
                  }

                  // จำกัดจำนวนรายการที่แสดงตาม displayedItems
                  final limitedItems =
                      items.take(displayedItems.value).toList();

                  return ListView.builder(
                    controller: scrollController, // ใช้ ScrollController
                    itemCount:
                        limitedItems.length + 1, // +1 สำหรับ loading indicator
                    itemBuilder: (context, index) {
                      // ถ้าถึงรายการสุดท้าย แสดง loading indicator
                      if (index == limitedItems.length) {
                        return items.length > displayedItems.value
                            ? const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: CircularProgressIndicator(),
                                ),
                              )
                            : const SizedBox.shrink();
                      }

                      return Card(
                        child: ListTile(
                          title: Text(limitedItems[index].title),
                          subtitle: Text(limitedItems[index].content),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.arrow_upward),
                                onPressed: () {
                                  context.read<TodoBloc>().add(
                                        UpdatePriorityTodo(
                                          id: limitedItems[index].id,
                                          priority:
                                              limitedItems[index].priority + 1,
                                        ),
                                      );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.arrow_downward),
                                onPressed: () {
                                  context.read<TodoBloc>().add(
                                        UpdatePriorityTodo(
                                          id: limitedItems[index].id,
                                          priority:
                                              limitedItems[index].priority - 1,
                                        ),
                                      );
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                color: PColor.errorColor,
                                onPressed: () {
                                  context.read<TodoBloc>().add(
                                      DeleteTodo(id: limitedItems[index].id));
                                },
                              ),
                            ],
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
                value: context.read<TodoBloc>(),
                child: AddTodoDialog(),
              ),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
