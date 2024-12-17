import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_lessons/home_work/home_work3/core/home_colors.dart';

import '../../data/task_data_home.dart';

class TaskHome extends StatefulWidget {
  final double top;
  final bool isDone;
  final Box<TaskDataHome> data;
  final DateTime time;

  const TaskHome({
    super.key,
    required this.top,
    this.isDone = false,
    required this.data,
    required this.time,
  });

  @override
  State<TaskHome> createState() => _TaskHomeState();
}

class _TaskHomeState extends State<TaskHome> {
  List<TaskDataHome> filterByDate(Box<TaskDataHome> taskData) {
    return taskData.values.where((item) {
      return item.dateTime.year == widget.time.year &&
          item.dateTime.month == widget.time.month &&
          item.dateTime.day == widget.time.day;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: widget.data.listenable(),
        builder: (context, Box<TaskDataHome> value, child) {
          final filteredTask = filterByDate(value);
          return filteredTask.isEmpty
              ? Container(
                  height: 200,
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 16, right: 16, top: widget.top),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Text(widget.isDone ? 'no finished task' : 'no tasks'),
                )
              : Container(
                  height: 80 * value.length.toDouble(),
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 16, right: 16, top: widget.top),
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: filteredTask.length,
                      itemBuilder: (context, index) {
                        final task = filteredTask[index];
                        return SizedBox(
                          height: 60,
                          child: Center(
                            child: ListTile(
                              // leading: CircleAvatar(
                              //   backgroundColor: widget.isDone
                              //       ? Colors.grey.shade200
                              //       : Colors.orange,
                              //   radius: 30,
                              //   child: Icon(
                              //     Icons.shopping_cart_outlined,
                              //     color: widget.isDone
                              //         ? Colors.grey
                              //         : HomeColors.primaryColor,
                              //   ),
                              // ),
                              title: Text(
                                task!.title,
                                style: TextStyle(
                                    decoration: widget.isDone
                                        ? TextDecoration.lineThrough
                                        : TextDecoration.none),
                              ),
                              trailing: IconButton(
                                onPressed: () {},
                                icon: widget.isDone
                                    ? const Icon(
                                        Icons.check_box,
                                        color: HomeColors.primaryColor,
                                      )
                                    : const Icon(Icons.check_box_outline_blank),
                              ),
                            ),
                          ),
                        );
                      }),
                );
        });
  }
}
