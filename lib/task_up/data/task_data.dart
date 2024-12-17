import 'package:hive/hive.dart';

part 'task_data.g.dart';

@HiveType(typeId: 3)
class Task {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final int color;

  @HiveField(3)
  final String iconKey;

  @HiveField(4)
  final DateTime dateTime;

  @HiveField(5)
  final int hour;

  @HiveField(6)
  final int minute;

  @HiveField(7)
  final String notes;

  Task(
      {required this.id,
      required this.title,
      required this.color,
      required this.iconKey,
      required this.dateTime,
      required this.hour,
      required this.minute,
      required this.notes});
}
