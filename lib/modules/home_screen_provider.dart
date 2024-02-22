import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:services/local_db_services/nosql_services/hive_db_helper.dart';
import 'package:todo_app/constants/box_names.dart';
import 'package:todo_app/models/task_model.dart';

class HomeScreenProvider extends ChangeNotifier with HiveDBHelper {
  List<Task>? tasks;
  int? _taskKey;
  TextEditingController taskTitleController = TextEditingController();
  TextEditingController taskDescriptionController = TextEditingController();

  void init() async {
    tasks = await fetchAllData(BoxNames.taskBox);
    log("init loaded successfully");
    log(tasks.toString());
    notifyListeners();
  }

  void addTask() async {
    Task task = Task(
      date: DateTime.now(),
      description: taskDescriptionController.text.toString(),
      title: taskTitleController.text.toString(),
    );
    _taskKey = await saveData(BoxNames.taskBox, task);
    await storeBoxKey(BoxNames.taskBox, _taskKey!);

    tasks!.add(task);
    notifyListeners();
  }

  void updateTask(int index, String updatedTitle, String updatedDescription) {
    Task updatedTask = Task(
      title: updatedTitle,
      description: updatedDescription,
      date: DateTime.now(),
    );

    // Update the task in the tasks list
    tasks![index] = updatedTask;

    // Update the task in the local database
    updateData(BoxNames.taskBox, index, updatedTask);

    // Notify listeners to trigger a rebuild
    notifyListeners();
  }

  void deleteTask(int index) {
    // Delete the task from the tasks list
    tasks!.removeAt(index);

    // Delete the task from the local database
    deleteData(BoxNames.taskBox, index);

    // Notify listeners to trigger a rebuild
    notifyListeners();
  }
}
