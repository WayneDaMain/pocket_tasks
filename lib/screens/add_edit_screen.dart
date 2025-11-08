import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_tasks/models/task_model.dart';
import 'package:pocket_tasks/providers/task_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:intl/intl.dart';

class AddEditTaskScreen extends ConsumerStatefulWidget {
  final TaskModel? existingTask;

  const AddEditTaskScreen({super.key, this.existingTask});

  @override
  ConsumerState<AddEditTaskScreen> createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends ConsumerState<AddEditTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late String _note;
  DateTime? _dueDate;

  @override
  void initState() {
    super.initState();
    _title = widget.existingTask?.title ?? '';
    _note = widget.existingTask?.note ?? '';
    _dueDate = widget.existingTask?.dueDate;
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final isEditing = widget.existingTask != null;

      late TaskModel task;
      if (isEditing) {
        task = widget.existingTask!;
        task.title = _title;
        task.note = _note;
        task.dueDate = _dueDate;
      } else {
        task = TaskModel(
          id: const Uuid().v4(),
          title: _title,
          note: _note,
          createdAt: DateTime.now(),
          dueDate: _dueDate,
        );
      }

      if (isEditing) {
        ref.read(taskListProvider.notifier).updateTask(task, context);
      } else {
        ref.read(taskListProvider.notifier).addTask(task, context);
      }

      Navigator.pop(context);
    }
  }

  Future<void> _pickDueDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) setState(() => _dueDate = picked);
  }

  @override
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final formContent = SingleChildScrollView(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Drag handle (for modal)
            if (ModalRoute.of(context)?.settings.name == null)
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 12),
                decoration: BoxDecoration(
                  color: Colors.grey[500],
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            Text(
              widget.existingTask == null ? 'Add Task' : 'Edit Task',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            TextFormField(
              initialValue: _title,
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (val) =>
                  val == null || val.isEmpty ? 'Enter title' : null,
              onSaved: (val) => _title = val!,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isDark ? Colors.grey[300] : Colors.grey[700],
              ),
            ),
            const SizedBox(height: 12),
            TextFormField(
              maxLines: 4,
              minLines: 1,
              initialValue: _note,
              decoration: const InputDecoration(labelText: 'Note'),
              onSaved: (val) => _note = val ?? '',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: isDark ? Colors.grey[300] : Colors.grey[700],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _dueDate == null
                        ? "No due date set"
                        : "Due: ${DateFormat('EEE, MMM d, yyyy').format(_dueDate!)}",
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isDark ? Colors.grey[300] : Colors.grey[700],
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: _pickDueDate,
                  icon: const Icon(Icons.calendar_today_outlined),
                  label: const Text("Pick Date"),
                ),
              ],
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _submit,
              icon: const Icon(Icons.check),
              label: const Text("Save Task"),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(48),
              ),
            ),
          ],
        ),
      ),
    );

    final isModal = ModalRoute.of(context)?.settings.name == null;

    return isModal
        ? Material(
            color: theme.scaffoldBackgroundColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: SafeArea(child: formContent),
          )
        : Scaffold(
            appBar: AppBar(
              title: Text(
                widget.existingTask == null ? 'Add Task' : 'Edit Task',
              ),
            ),
            body: SafeArea(child: formContent),
          );
  }
}
