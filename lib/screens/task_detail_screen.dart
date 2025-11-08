import 'package:flutter/material.dart';
import 'package:pocket_tasks/models/task_model.dart';

class TaskDetailScreen extends StatelessWidget {
  final TaskModel task;

  const TaskDetailScreen({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Hero(
          tag: task.id,
          child: Material(color: Colors.transparent, child: Text(task.title)),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Note:", style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(task.note),
            const SizedBox(height: 16),
            if (task.dueDate != null)
              Text("Due: ${task.dueDate!.toLocal().toString().split(' ')[0]}"),
            const SizedBox(height: 16),
            Text("Status: ${task.isCompleted ? 'Completed' : 'Pending'}"),
          ],
        ),
      ),
    );
  }
}
