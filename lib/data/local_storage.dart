import 'package:hive/hive.dart';
import '../models/task_model.dart';

class LocalStorage {
  static const boxName = 'tasksBox';

  Future<void> init() async {
    Hive.registerAdapter(TaskModelAdapter());
    await Hive.openBox<TaskModel>(boxName);
  }

  Box<TaskModel> get box => Hive.box<TaskModel>(boxName);

  List<TaskModel> getTasks() => box.values.toList();

  Future<void> addTask(TaskModel task) => box.put(task.id, task);

  Future<void> deleteTask(String id) => box.delete(id);

  Future<void> updateTask(TaskModel task) => task.save();
}
