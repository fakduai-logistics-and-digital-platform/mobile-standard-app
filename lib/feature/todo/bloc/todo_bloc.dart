import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app_standard/domain/datasource/app_datebase.dart';
import 'package:mobile_app_standard/domain/repositories/todo_repo.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoRepository todoRepository;

  TodoBloc({required this.todoRepository}) : super(TodoInitial()) {
    on<LoadTodos>(_onLoadTodos);
    on<AddTodo>(_onAddTodo);
    on<DeleteTodo>(_onDeleteTodo);
    add(LoadTodos());
  }

  Future<void> _onLoadTodos(LoadTodos event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      final todos = await todoRepository.getAllTodoItems();
      if (kDebugMode) {
        print('Loaded todos: $todos');
      }
      emit(TodoLoaded(todos));
    } catch (e) {
      if (kDebugMode) {
        print('Failed to load todos: $e');
      }
      emit(TodoError('Failed to load todos.'));
    }
  }

  Future<void> _onAddTodo(AddTodo event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      await todoRepository.addTodoItem(event.title, event.content);
      add(LoadTodos());
    } catch (e) {
      emit(TodoError('Failed to add todo: ${e.toString()}'));
    }
  }

  Future<void> _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      await todoRepository.deleteTodoItem(event.id);
      add(LoadTodos());
    } catch (e) {
      emit(TodoError('Failed to delete todo: ${e.toString()}'));
    }
  }
}
