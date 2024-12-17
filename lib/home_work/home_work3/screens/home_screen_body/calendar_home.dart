import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/material.dart';
import 'package:hive_lessons/home_work/home_work3/core/home_colors.dart';

class CalendarHome extends StatelessWidget {
  const CalendarHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        height: 250,
        width: double.infinity,
        color: HomeColors.primaryColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DatePicker(
              height: 100,
              DateTime.now(),
              initialSelectedDate: DateTime.now(),
              selectionColor: Colors.white,
              selectedTextColor: Colors.black,
              onDateChange: (date){
              },
            )
          ],
        ),
      ),
    );
  }
}
