import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'employee.dart';

class AddWorkers extends StatefulWidget {
  const AddWorkers({super.key});

  @override
  State<AddWorkers> createState() => _AddWorkersState();
}

class _AddWorkersState extends State<AddWorkers> {

  final Box<Workers> workers = Hive.box<Workers>('workers');

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController experienceController = TextEditingController();
  TextEditingController salaryController = TextEditingController();

  void addWorkers() {
    if (nameController.text.isNotEmpty && surnameController.text.isNotEmpty &&
        experienceController.text.isNotEmpty &&
        salaryController.text.isNotEmpty) {
      workers.add(Workers(name: nameController.text,
          surname: surnameController.text,
          experience: int.tryParse(experienceController.text) ?? 0,
          salary: double.tryParse(salaryController.text) ?? 0));
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              _textField(text: 'name', controller: nameController),
              const SizedBox(height: 10,),
              _textField(text: 'surname', controller: surnameController),
              const SizedBox(height: 10,),
              _textField(text: 'experience', controller: experienceController),
              const SizedBox(height: 10,),
              _textField(text: 'salary', controller: salaryController),
              const SizedBox(height: 40,),
              ElevatedButton(onPressed: (){
                addWorkers();
              }, child: const Text('add worker')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField(
      {required String text, required TextEditingController controller}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: text,
      ),
    );
  }
}
