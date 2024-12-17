import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import 'data.dart';

class AddScreen extends StatefulWidget {
  const AddScreen({super.key});

  @override
  State<AddScreen> createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();

  final Box<Contacts> numbers = Hive.box<Contacts>('numbers');

  void addNumber(){
    if(nameController.text.isNotEmpty && numberController.text.isNotEmpty){
      numbers.add(Contacts(name: nameController.text, number: int.tryParse(numberController.text) ?? 0),);
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _textField(text: 'name', controller: nameController),
              const SizedBox(height: 10,),
              _textField(text: 'number', controller: numberController),
              const SizedBox(height: 40,),
              ElevatedButton(onPressed: (){
                addNumber();
              }, child: const Text('add contacts'),),
            ],
          ),
        ),
      ),
    );
  }

  Widget _textField({required String text, required TextEditingController controller}){
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
            hintText: text,
      ),
    );
  }
}
