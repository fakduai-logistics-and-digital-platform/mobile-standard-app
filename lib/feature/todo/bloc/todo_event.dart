part of 'todo_bloc.dart';

@immutable
sealed class TodoEvent {}

class LoadTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final String title;
  final String content;

  AddTodo({
    required this.title,
    required this.content,
  });
}

class DeleteTodo extends TodoEvent {
  final int id;

  DeleteTodo({required this.id});
}
