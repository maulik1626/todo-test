import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
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
    // Get the tasks from the firebase
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final CollectionReference todoTasks = firestore.collection('todo');
    final DocumentSnapshot snapshot = await todoTasks.doc('tasks').get();
    final data = snapshot.data();
    print('data: ${data.runtimeType}');
    print('data: ${data.toString()}');

    // Get the tasks from the local database
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

  void updateTask(int index, String updatedTitle, String updatedDescription) async {
    Task updatedTask = Task(
      title: updatedTitle,
      description: updatedDescription,
      date: DateTime.now(),
    );

    tasks![index] = updatedTask;

    _taskKey = await retrieveBoxKey(BoxNames.taskBox);

    updateData(BoxNames.taskBox, _taskKey!, updatedTask);

    // Notify listeners to trigger a rebuild
    notifyListeners();
  }

  void deleteTask(int index) async {
    tasks!.removeAt(index);

    _taskKey = await retrieveBoxKey(BoxNames.taskBox);

    deleteData(BoxNames.taskBox, _taskKey!);

    notifyListeners();
  }
}
