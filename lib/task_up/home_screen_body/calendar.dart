import 'package:flutter/material.dart';
import 'package:hive_lessons/task_up/core/app_colors.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';

class Calendar extends StatelessWidget {
  final Function(DateTime) onDateChange;
  const Calendar({super.key, required this.onDateChange});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child:
          Container(
            height: 250,
              width: double.infinity,
            color: AppColors.primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                DatePicker(
                  height: 100,
                  DateTime.now(),
                  initialSelectedDate: DateTime.now(),
                  selectionColor: Colors.black,
                  selectedTextColor: Colors.white,
                  onDateChange: onDateChange,
                ),
              ],
            )
          ),

    );
  }
}
