

import 'package:hive/hive.dart';
import 'package:todo_app/models/task_model.dart';

class RegisterHiveAdapters {
  static void register() {
    Hive.registerAdapter(TaskAdapter());
  }
}