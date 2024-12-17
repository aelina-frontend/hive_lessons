import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_lessons/home_work/home_work2/home_work2.dart';
import 'package:hive_lessons/home_work/home_work3/screens/home_main_screen.dart';
import 'package:hive_lessons/home_work/home_work3/screens/home_screen_body/add_task_screen.dart';
import 'package:hive_lessons/lesson1/lesson1.dart';
import 'package:hive_lessons/lesson1/local_storage.dart';

import 'package:hive_lessons/lesson2/lesson2.dart';
import 'package:hive_lessons/task_up/data/task_data.dart';
import 'package:hive_lessons/task_up/screens/add_screen.dart';
import 'package:hive_lessons/task_up/screens/home_screen.dart';

import 'home_work/home_work2/employee.dart';
import 'home_work/home_work3/data/task_data_home.dart';
import 'lesson2/data.dart';

import 'package:device_preview/device_preview.dart';

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(TaskDataHomeAdapter());

  await Hive.openBox<Task>('task');
  await Hive.openBox<Task>('completedTask');

  await Hive.openBox<TaskDataHome>('homeTask');
  await Hive.openBox<TaskDataHome>('finishedTask');

  runApp(
    DevicePreview(
      enabled: !kReleaseMode,
      builder: (context) => MyApp(), // Wrap your app
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}

// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Hive.initFlutter();
//   Hive.registerAdapter(ContactsAdapter());
//   Hive.registerAdapter(WorkersAdapter());
//   await Hive.openBox('practice');
//   await Hive.openBox<Workers>('workers');
//   await Hive.openBox<String>('books');
//   await Hive.openBox<int>('dress');
//   await Hive.openBox<Map<String,dynamic>>('cars');
//   await Hive.openBox<House>('house');
//   await Hive.openBox<Contacts>('numbers');
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Lesson2(),
//     );
//   }
// }

class House {
  final String name;
  final int price;

  House({required this.name, required this.price});
}

List<House> house = [
  House(name: 'apartment', price: 70000),
  House(name: 'home', price: 100000)
];
List<String> books = ['vino is aduvanchikov', 'djeck london', 'plaha', 'djamilya'];
List<int> dress = [001,003,005];
List<Map<String, dynamic>> cars = [
  {
    'name': 'BMW',
    'price': 20000,
  },
  {
    'name': 'Mersedes',
    'price': 7000,
  },
  {
    'name': 'Lexus',
    'price': 50000,
  }
];

String name = 'Alice';
String surname = 'Omarova';

Person alice = Person(name: 'Alice', surname: 'Kilimova');

class Person {
  final String name;
  final String surname;

  Person({required this.name, required this.surname});

}