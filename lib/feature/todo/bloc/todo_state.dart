part of 'todo_bloc.dart';

@immutable
sealed class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<TodoItem> todos;

  TodoLoaded(this.todos);
}

class TodoError extends TodoState {
  final String message;

  TodoError(this.message);
}

class TodoAdded extends TodoState {
  final List<TodoItem> todos;

  TodoAdded(this.todos);
}
