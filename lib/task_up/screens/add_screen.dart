import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:hive_lessons/task_up/core/app_navigation.dart';
import 'package:hive_lessons/task_up/data/category_data.dart';
import 'package:hive_lessons/task_up/widgets/elevated_button_widget.dart';

import '../core/app_colors.dart';
import '../data/task_data.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  final Box<Task> task = Hive.box<Task>('task');

  TextEditingController titleController = TextEditingController();
  TextEditingController notesController = TextEditingController();

  List<int> colors = [
    0xFFFF9800,
    0xFF4CAF50,
    0xFF2196F3,
  ];

  void addTask() {
    if (titleController.text.isNotEmpty &&
        notesController.text.isNotEmpty &&
        selectedIndex != null &&
        selectedDate != null &&
        selectedTime != null) {
      task.add(Task(
          id: DateTime.now().toString(),
          title: titleController.text,
          color: colors[selectedIndex!],
          iconKey: icons.keys.toList()[selectedIndex!],
          dateTime: selectedDate!,
          hour: selectedTime!.hour,
          minute: selectedTime!.minute,
          notes: notesController.text));
    }
    AppNavigation.pop(context);
  }

  DateTime? selectedDate;
  int? selectedIndex;
  TimeOfDay? selectedTime;

  Future<void> _selectTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
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
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: () {
            AppNavigation.pop(context);
          },
          icon: const Icon(
            Icons.cancel,
            color: AppColors.white,
            size: 40,
          ),
        ),
        title: const Text(
          'Add new Task',
          style: TextStyle(
              color: AppColors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            _text(text: 'Task Title'),
            _textField(hintText: 'Task Title', controller: titleController),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _text(text: 'Category'),
                const SizedBox(
                  width: 10,
                ),
                _category(
                    icon: Icons.list_alt_outlined,
                    color: AppColors.backgroundColor),
              ],
            ),
            // _category(icon: Icons.calendar_today, color: AppColors.backgroundColor),
            // _category(icon: Icons.local_bar_outlined, color: AppColors.backgroundColor),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _text(text: 'Date'),
                    _showButton(
                        onTap: () {
                          _selectDate();
                        },
                        text: selectedDate != null
                            ? '${_formatDate(selectedDate!)}'
                            : 'Date',
                        icon: Icons.calendar_today),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _text(text: 'Time'),
                    _showButton(
                        onTap: () {
                          _selectTime();
                        },
                        text: selectedTime != null
                            ? '${selectedTime!.hour} : ${selectedTime!.minute}'
                            : 'Time',
                        icon: Icons.access_time_outlined),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            _text(text: 'Notes'),
            _textField(
                hintText: 'Notes', maxLines: 5, controller: notesController),
            const SizedBox(
              height: 50,
            ),
            ElevatedButtonWidget(
                text: 'Save',
                onPressed: () {
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

  Widget _textField(
      {required String hintText,
      int maxLines = 1,
      required TextEditingController controller}) {
    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: hintText,
        fillColor: AppColors.white,
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
          width: 170,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(color: AppColors.grey),
            color: AppColors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(text),
              Icon(
                icon,
                color: AppColors.primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _category({
    required IconData icon,
    required Color color,
  }) {
    return Expanded(
      child: SizedBox(
        height: 80,
        child: ListView.builder(
          itemCount: data.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            final isSelected = selectedIndex == index;
            return Padding(
              padding: const EdgeInsets.only(right: 10),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor:
                      isSelected ? AppColors.primaryColor : AppColors.white,
                  child: CircleAvatar(
                    radius: 25,
                    backgroundColor: data[index].backgroundColor,
                    child: Icon(data[index].icon),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
