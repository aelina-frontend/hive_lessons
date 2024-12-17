import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_lessons/task_up/core/app_colors.dart';
import 'package:hive/hive.dart';
import 'package:hive_lessons/task_up/data/category_data.dart';
import '../data/task_data.dart';

class TaskBody extends StatefulWidget {
  final double top;
  final bool isDone;
  final DateTime time;
  final Box<Task> data;

  const TaskBody({
    super.key,
    required this.top,
    this.isDone = false,
    required this.time,
    required this.data,
  });

  @override
  State<TaskBody> createState() => _TaskBodyState();
}

class _TaskBodyState extends State<TaskBody> {
  bool filterByDate(Task taskData) {
    return taskData.dateTime.year == widget.time.year &&
        taskData.dateTime.month == widget.time.month &&
        taskData.dateTime.day == widget.time.day;
  }


  // Add task to completedTask and remove from the main task list
  void addCompletedTask(String id, Task taskData) {
    widget.isDone ? widget.data.put(id, taskData);
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable:
         widget.data.listenable(),
      builder: (context, Box<Task> box, child) {
        final filterTask = box.values.where(filterByDate).toList();

        // If no tasks

        return filterTask.isEmpty
            ? Container(
                height: 200,
                width: double.infinity,
                margin: EdgeInsets.only(left: 16, right: 16, top: widget.top),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(widget.isDone ? 'no completed task' : 'no tasks'),
              )
            :

            // Tasks list
            Container(
                height: 80 * filterTask.length.toDouble(),
                width: double.infinity,
                margin: EdgeInsets.only(left: 16, right: 16, top: widget.top),
                alignment: Alignment.topCenter,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: filterTask.length,
                  itemBuilder: (context, index) {
                    final task = filterTask[index];

                    return SizedBox(
                      height: 60,
                      child: Center(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: widget.isDone
                                ? Colors.grey.shade200
                                : Color(task.color),
                            radius: 30,
                            child: Icon(
                              icons[task.iconKey],
                              color: widget.isDone
                                  ? Colors.grey
                                  : AppColors.primaryColor,
                            ),
                          ),
                          title: Text(
                            task.title,
                            style: TextStyle(
                              decoration: widget.isDone
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          subtitle: Text(
                            task.notes,
                            style: TextStyle(
                              decoration: widget.isDone
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: widget.isDone
                                ? () {}
                                : () {
                                    addCompletedTask(
                                        task.id,
                                        Task(
                                            id: task.id,
                                            title: task.title,
                                            color: task.color,
                                            iconKey: task.iconKey,
                                            dateTime: task.dateTime,
                                            hour: task.hour,
                                            minute: task.minute,
                                            notes: task.notes));
                                    setState(() {});
                                  },
                            icon: widget.isDone
                                ? const Icon(
                                    Icons.check_box,
                                    color: AppColors.primaryColor,
                                  )
                                : const Icon(Icons.check_box_outline_blank),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
      },
    );
  }
}
