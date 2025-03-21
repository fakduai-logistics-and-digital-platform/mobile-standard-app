import 'package:mobile_app_standard/domain/datasource/app_datebase.dart';

abstract class TodoRepositoryInterface {
  Future<void> addTodoItem(String title, String content);
  Future<List<TodoItem>> getAllTodoItems();
  Future<void> deleteTodoItem(int id);
}

class TodoRepository extends TodoRepositoryInterface {
  final AppDatabase db;

  // Constructor รับฐานข้อมูล
  TodoRepository(this.db);

  @override
  Future<void> addTodoItem(String title, String content) async {
    await db.into(db.todoItems).insert(
          TodoItemsCompanion.insert(
            title: title,
            content: content,
          ),
        );
  }

  @override
  Future<List<TodoItem>> getAllTodoItems() async {
    return await db.select(db.todoItems).get();
  }

  @override
  Future<void> deleteTodoItem(int id) async {
    await (db.delete(db.todoItems)..where((tbl) => tbl.id.equals(id))).go();
  }
}
