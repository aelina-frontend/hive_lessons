import 'package:flutter/material.dart';
import 'package:hive_lessons/home_work/home_work3/core/home_colors.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Function() onPressed;

  const ButtonWidget(this.text, this.onPressed, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(backgroundColor: HomeColors.primaryColor),
          child: Text(text, style: const TextStyle(color: HomeColors.white, fontSize: 16, fontWeight: FontWeight.bold),),
        ),
      ),
    );
  }
}
