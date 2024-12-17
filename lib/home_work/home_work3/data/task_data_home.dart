import 'package:hive/hive.dart';

part 'task_data_home.g.dart';

@HiveType(typeId: 4)
class TaskDataHome {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final DateTime dateTime;


  TaskDataHome(
      {required this.id,
        required this.title,
      required this.dateTime,
});
}
