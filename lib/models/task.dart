import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 2)
class Task {
  @HiveField(0)
  String text;
  @HiveField(1)
  bool isDone;
  @HiveField(2)
  String topic;

  Task({
    required this.text,
    required this.isDone,
    required this.topic,
  });
}
