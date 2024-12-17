import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_lessons/task_up/core/app_colors.dart';
import 'package:hive_lessons/task_up/core/app_navigation.dart';
import 'package:hive_lessons/task_up/home_screen_body/calendar.dart';
import 'package:hive_lessons/task_up/home_screen_body/task_body.dart';
import 'package:hive_lessons/task_up/screens/add_screen.dart';
import 'package:hive_lessons/task_up/widgets/elevated_button_widget.dart';

import '../data/task_data.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final Box<Task> task = Hive.box<Task>('task');
  final Box<Task> completedTask = Hive.box<Task>('completedTask');

  double height = 80;
  int itemCount = 2;
  DateTime time = DateTime.now();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              children: [
                Calendar(
                  onDateChange: (date){
                    setState(() {
                      time = date;
                    });
                  },
                ),
                TaskBody(
                  data: task,
                  time: time,
                  top: 180,
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 16),
                    child: Text(
                      'Completed',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: TaskBody(
              data: completedTask,
              time: time,
              isDone: true,
              top: 0,
            ),
          ),
          const SliverToBoxAdapter(
            child: SizedBox(
              height: 100,
            ),
          )
        ],
      ),
      floatingActionButton: ElevatedButtonWidget(
          text: 'Add New Task',
          onPressed: () {
            AppNavigation.push(
              context,
              const AddScreen(),
            );
          }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
