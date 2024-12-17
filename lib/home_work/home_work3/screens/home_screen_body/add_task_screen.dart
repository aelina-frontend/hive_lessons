import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_lessons/home_work/home_work3/core/app_navigator_home.dart';
import 'package:hive_lessons/home_work/home_work3/core/home_colors.dart';
import 'package:hive_lessons/home_work/home_work3/widgets/button_widget.dart';

import '../../data/task_data_home.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final Box<TaskDataHome> task = Hive.box<TaskDataHome>('homeTask');

  TextEditingController titleController = TextEditingController();

  DateTime? selectedDate;
  

  void addTask() {
    if (titleController.text.isNotEmpty &&
        selectedDate != null) {
      task.add(
        TaskDataHome(
          id: DateTime.now().toString(),
          title: titleController.text,
          dateTime: selectedDate!,
        ),
      );
      AppNavigatorHome.pop(context);
    }
  }

  Future<void> _selectDate() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(2017),
      lastDate: DateTime(2030),
      initialDate: DateTime.now(),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomeColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: HomeColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            AppNavigatorHome.pop(context);
          },
          icon: const Icon(
            Icons.cancel,
            color: HomeColors.white,
            size: 40,
          ),
        ),
        title: const Text(
          'Добавить новую задачу',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            _text(text: 'Название задачи'),
            _textField(
                controller: titleController, hintText: 'Название задачи'),
            const SizedBox(
              height: 20,
            ),
            _text(text: 'Дата'),
            _showButton(
                onTap: () {
                  _selectDate();
                },
                text: selectedDate != null
                    ? '${_formatDate(selectedDate!)}'
                    : 'Дата',
                icon: Icons.calendar_today),
            const SizedBox(
              height: 50,
            ),
            ButtonWidget('Сохранить', () {
              addTask();
            }),
          ],
        ),
      ),
    );
  }

  Widget _text({required String text}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _textField({
    required TextEditingController controller,
    required String hintText,
    int maxLine = 1,
  }) {
    return TextField(
      controller: controller,
      maxLines: maxLine,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
        fillColor: HomeColors.white,
        filled: true,
      ),
    );
  }

  Widget _showButton(
      {required Function() onTap,
      required String text,
      required IconData icon}) {
    return GestureDetector(
      onTap: onTap,
      child: Expanded(
        child: Container(
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: HomeColors.grey),
            color: HomeColors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text),
              Icon(
                icon,
                color: HomeColors.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
