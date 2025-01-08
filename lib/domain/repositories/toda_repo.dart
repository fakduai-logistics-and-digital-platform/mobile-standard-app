import 'package:flutter/foundation.dart';
import 'package:mobile_app_standard/domain/datasource/app_datebase.dart'; // สำหรับ kDebugMode

class TodoRepository {
  final AppDatabase db;

  // Constructor รับฐานข้อมูล
  TodoRepository(this.db);

  // เพิ่มรายการใหม่ในฐานข้อมูล
  Future<void> addTodoItem(String title, String content) async {
    await db.into(db.todoItems).insert(
          TodoItemsCompanion.insert(
            title: title,
            content: content,
          ),
        );
  }

  // ดึงรายการทั้งหมดในฐานข้อมูล
  Future<List<TodoItem>> getAllTodoItems() async {
    return await db.select(db.todoItems).get();
  }

  // พิมพ์รายการทั้งหมดในฐานข้อมูลในโหมดดีบั๊ก
  Future<void> debugPrintAllItems() async {
    if (kDebugMode) {
      List<TodoItem> allItems = await getAllTodoItems();
      print('Items in database: $allItems');
    }
  }
}
