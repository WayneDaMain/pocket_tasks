import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_tasks/models/task_model.dart';
import 'package:pocket_tasks/providers/task_provider.dart';
import 'package:pocket_tasks/providers/theme_provider.dart';
import 'package:pocket_tasks/screens/add_edit_screen.dart';
import 'package:pocket_tasks/widgets/filter_buttons.dart';
import 'package:pocket_tasks/widgets/task_tile.dart';
import 'package:pocket_tasks/utils/enums.dart';

final filterProvider = StateProvider<TaskFilter>((ref) => TaskFilter.all);
final sortProvider = StateProvider<SortType>((ref) => SortType.createdAt);
final searchQueryProvider = StateProvider<String>((ref) => '');

class TaskListScreen extends ConsumerWidget {
  const TaskListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskListProvider);
    final filter = ref.watch(filterProvider);
    final sort = ref.watch(sortProvider);
    final searchQuery = ref.watch(searchQueryProvider).toLowerCase();

    // Apply filter
    List<TaskModel> filtered = switch (filter) {
      TaskFilter.completed => tasks.where((t) => t.isCompleted).toList(),
      TaskFilter.active => tasks.where((t) => !t.isCompleted).toList(),
      _ => tasks,
    };

    // Apply search
    if (searchQuery.isNotEmpty) {
      filtered = filtered
          .where((t) => t.title.toLowerCase().contains(searchQuery))
          .toList();
    }

    // Apply sort
    filtered.sort((a, b) {
      if (sort == SortType.dueDate) {
        return (a.dueDate ?? DateTime(2100)).compareTo(
          b.dueDate ?? DateTime(2100),
        );
      } else {
        return a.createdAt.compareTo(b.createdAt);
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pocket Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.brightness_6_rounded),
            onPressed: () {
              ref.read(themeModeProvider.notifier).toggleTheme();
            },
          ),
          PopupMenuButton<SortType>(
            icon: const Icon(Icons.sort_rounded),
            onSelected: (value) =>
                ref.read(sortProvider.notifier).state = value,
            itemBuilder: (context) => const [
              PopupMenuItem(
                value: SortType.createdAt,
                child: Text("Sort by Created"),
              ),
              PopupMenuItem(
                value: SortType.dueDate,
                child: Text("Sort by Due Date"),
              ),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search tasks...",
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                ),
              ),
              onChanged: (value) =>
                  ref.read(searchQueryProvider.notifier).state = value,
            ),
          ),
          const SizedBox(height: 8),
          const FilterButtons(),
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Text(
                        () {
                          switch (filter) {
                            case TaskFilter.completed:
                              return "No completed tasks yet.";
                            case TaskFilter.active:
                              return "No active tasks left. Great job!";
                            default:
                              return "No tasks yet. Add your first task to begin!";
                          }
                        }(),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                    ),
                  )
                : ListView.builder(
                    itemCount: filtered.length,
                    padding: const EdgeInsets.only(bottom: 80),
                    itemBuilder: (context, index) {
                      final task = filtered[index];
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Material(
                          color: Colors.transparent,
                          child: TaskTile(
                            task: task,
                            onToggle: () => ref
                                .read(taskListProvider.notifier)
                                .toggleComplete(task, context),
                            onDelete: () => ref
                                .read(taskListProvider.notifier)
                                .deleteTask(task.id, context),
                            onTap: () => Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    AddEditTaskScreen(existingTask: task),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          builder: (_) => Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: const AddEditTaskScreen(),
          ),
        ),
        child: const Icon(Icons.add_task_rounded),
      ),
    );
  }
}
