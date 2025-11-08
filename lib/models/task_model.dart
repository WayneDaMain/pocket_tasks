import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class TaskModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  String note;

  @HiveField(3)
  DateTime createdAt;

  @HiveField(4)
  DateTime? dueDate;

  @HiveField(5)
  bool isCompleted;

  TaskModel({
    required this.id,
    required this.title,
    required this.note,
    required this.createdAt,
    this.dueDate,
    this.isCompleted = false,
  });

  copyWith({required bool isCompleted}) {}
}
