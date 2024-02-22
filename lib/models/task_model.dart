import 'package:hive/hive.dart';

part 'task_model.g.dart';

@HiveType(typeId: 0)
class Task {
  @HiveField(0)
  final String title;
  @HiveField(1)
  final String description;
  @HiveField(2)
  final DateTime date;

  Task({
    required this.title,
    required this.description,
    required this.date,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
        title: json["title"] ?? "",
        description: json["description"] ?? "",
        date: DateTime.parse(json["date"] ?? ""),
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "description": description,
        "date": date.toIso8601String(),
      };

  @override
  String toString() {
    return 'Task{title: $title, description: $description, date: $date}';
  }
}