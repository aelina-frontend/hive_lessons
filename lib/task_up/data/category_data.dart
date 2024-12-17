import 'package:flutter/material.dart';
import 'package:hive_lessons/task_up/core/app_colors.dart';

class CategoryData {
  final Color backgroundColor;
  final IconData icon;

  CategoryData({required this.backgroundColor, required this.icon});
}

List<CategoryData> data = [
  CategoryData(backgroundColor: AppColors.orange, icon: Icons.list_alt_rounded),
  CategoryData(backgroundColor: AppColors.green, icon: Icons.calendar_today),
  CategoryData(backgroundColor: AppColors.blue, icon: Icons.shopping_cart_outlined),
];

Map<String, IconData> icons = {
  'work': Icons.list_alt_rounded,
  'calendar': Icons.calendar_today,
  'shopping': Icons.shopping_cart_outlined,
};