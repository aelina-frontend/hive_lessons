import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_lessons/home_work/home_work3/core/app_navigator_home.dart';
import 'package:hive_lessons/home_work/home_work3/core/home_colors.dart';
import 'package:hive_lessons/home_work/home_work3/screens/home_screen_body/add_task_screen.dart';
import 'package:hive_lessons/home_work/home_work3/screens/home_screen_body/calendar_home.dart';
import 'package:hive_lessons/home_work/home_work3/screens/home_screen_body/task_home.dart';
import 'package:hive_lessons/home_work/home_work3/widgets/button_widget.dart';

import '../data/task_data_home.dart';

class HomeMainScreen extends StatefulWidget {
  const HomeMainScreen({super.key});

  @override
  State<HomeMainScreen> createState() => _HomeMainScreenState();
}

class _HomeMainScreenState extends State<HomeMainScreen> {
  final Box<TaskDataHome> task = Hive.box<TaskDataHome>('homeTask');
  final Box<TaskDataHome> finishedTask = Hive.box<TaskDataHome>('finishedTask');

  double height = 80;
  int itemCount = 2;
  DateTime time = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HomeColors.backgroundColor,
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Stack(
                children: [
                  const CalendarHome(),
                  TaskHome(top: 180, data: task, time: time),
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
                        'Выполненные задачи',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: TaskHome(top: 0, data: finishedTask, time: time),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 100,
              ),
            ),
          ],
        ),
        floatingActionButton: ButtonWidget('Добавить задачу', () {
          AppNavigatorHome.push(
            context,
            const AddTaskScreen(),
          );
        }));
  }
}
