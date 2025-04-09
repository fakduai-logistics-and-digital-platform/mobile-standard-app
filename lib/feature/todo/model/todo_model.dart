import 'package:mobile_app_standard/domain/datasource/app_datebase.dart';

class TodoModel {
  final int id;
  final String title;
  final String content;
  final DateTime createdAt;
  final int priority;

  TodoModel({
    required this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.priority,
  });

  factory TodoModel.fromJson(Map<String, dynamic> json) {
    return TodoModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      createdAt: DateTime.parse(json['createdAt']),
      priority: json['priority'],
    );
  }

  factory TodoModel.fromDrift(TodoItem data) {
    return TodoModel(
      id: data.id,
      title: data.title,
      content: data.content,
      createdAt: data.createdAt ?? DateTime.now(),
      priority: data.priority,
    );
  }

  toJSON() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'createdAt': createdAt.toUtc().toIso8601String(),
      'priority': 0,
    };
  }
}
