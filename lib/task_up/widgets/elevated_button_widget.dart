import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_lessons/task_up/core/app_colors.dart';

class ElevatedButtonWidget extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const ElevatedButtonWidget(
      {super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primaryColor,),
          child: Text(text, style: TextStyle(color: AppColors.white, fontSize: 16, fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
