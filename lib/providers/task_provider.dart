import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import '../data/local_storage.dart';

final localStorageProvider = Provider<LocalStorage>((ref) => LocalStorage());

final taskListProvider =
    StateNotifierProvider<TaskListNotifier, List<TaskModel>>((ref) {
      return TaskListNotifier(ref.read(localStorageProvider));
    });

class TaskListNotifier extends StateNotifier<List<TaskModel>> {
  final LocalStorage storage;

  TaskListNotifier(this.storage) : super([]) {
    _loadTasks();
  }

  void _loadTasks() {
    state = storage.getTasks();
  }

  void addTask(TaskModel task, BuildContext context) {
    storage.addTask(task);
    state = [...state, task];

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Task added')));
  }

  void updateTask(TaskModel task, BuildContext context) {
    storage.updateTask(task);
    state = [...state];

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Task updated')));
  }

  void deleteTask(String id, BuildContext context) {
    final task = state.firstWhere((t) => t.id == id);
    storage.deleteTask(id);
    state = state.where((t) => t.id != id).toList();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Task deleted'),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            storage.addTask(task);
            state = [...state, task];
          },
        ),
      ),
    );
  }

  void toggleComplete(TaskModel task, BuildContext context) {
    task.isCompleted = !task.isCompleted;
    storage.updateTask(task);
    state = [...state];

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          task.isCompleted ? 'Marked as complete' : 'Marked as active',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
