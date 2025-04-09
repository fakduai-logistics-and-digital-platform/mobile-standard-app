import 'package:drift/drift.dart';
import 'package:mobile_app_standard/domain/datasource/app_datebase.dart';

abstract class TodoRepositoryInterface {
  Future<void> addTodoItem(String title, String content);
  Future<List<TodoItem>> getAllTodoItems();
  Future<void> deleteTodoItem(int id);
  Future<void> updatePriorityTodoItem(int id, int priority);
}

class TodoRepository extends TodoRepositoryInterface {
  final AppDatabase db;

  // Constructor รับฐานข้อมูล
  TodoRepository(this.db);

  @override
  Future<void> addTodoItem(String title, String content) async {
    // Get the current max priority (or default to 0 if there are none)
    final maxPriorityResult = await (db.selectOnly(db.todoItems)
          ..addColumns([db.todoItems.priority.max()]))
        .getSingle();

    final currentMaxPriority =
        maxPriorityResult.read(db.todoItems.priority.max()) ?? 0;
    final newPriority = currentMaxPriority + 1;

    await db.into(db.todoItems).insert(
          TodoItemsCompanion.insert(
            title: title,
            content: content,
            priority: Value(newPriority),
          ),
        );
  }

  @override
  Future<List<TodoItem>> getAllTodoItems() async {
    return await (db.select(db.todoItems)
          ..orderBy([
            (t) => OrderingTerm(expression: t.priority, mode: OrderingMode.desc)
          ]))
        .get();
  }

  @override
  Future<void> deleteTodoItem(int id) async {
    await (db.delete(db.todoItems)..where((tbl) => tbl.id.equals(id))).go();
  }

  @override
  Future<void> updatePriorityTodoItem(int id, int priority) async {
    await (db.update(db.todoItems)..where((tbl) => tbl.id.equals(id)))
        .write(TodoItemsCompanion(priority: Value(priority)));
  }
}
