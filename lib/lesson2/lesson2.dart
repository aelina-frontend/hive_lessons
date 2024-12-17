import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_lessons/lesson2/add_screen.dart';

import 'data.dart';

class Lesson2 extends StatefulWidget {
  const Lesson2({super.key});

  @override
  State<Lesson2> createState() => _Lesson2State();
}

class _Lesson2State extends State<Lesson2> {
  final Box<Contacts> numbers = Hive.box<Contacts>('numbers');
  final Box practice = Hive.box('practice');

  TextEditingController nameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController updateController = TextEditingController();

  Future<void> allMethods() async {
    //TODO обновление
    await numbers.put('name', Contacts(name: '', number: 3));
    await practice.putAll({
      'name': 'Aelina',
      'surname': 'Karymshakova',
      'age': 30,
    });
    await practice.putAt(0, 'personal number');

    //TODO удаление данных
    await practice.clear();
    await practice.delete('surname');
    await practice.deleteAll(['name', 'numbers']);
    await practice.deleteAt(0);

    //TODO добавление данных
    await practice.add('Marice');
    await practice.addAll(
      [
        Contacts(name: 'Bermet', number: 0999999999),
        Contacts(name: 'Marina', number: 0555555555),
      ],
    );

    //TODO чтение данных CRUD: create, read, update, delete
    await practice.get('name');
    await practice.getAt(2);
    await practice.values;
    await practice.keys;
    await practice.keyAt(0);
    await practice.valuesBetween(startKey: 2000, endKey: 2010);
    await practice.valuesBetween(
      startKey: DateTime(2024, 01, 01),
      endKey: DateTime(2024, 01, 31),
    );

    //TODO other methods
    await practice.containsKey('phone');
    await practice.close();
    await practice.compact();
    await practice.deleteFromDisk();
    await practice.flush();
    await practice.watch();
  }

  List<String> tasks = [''];

  Future<void> delete() async {
    await numbers.deleteAt(0);
    Navigator.pop(context);
  }

  Future<void> update(int index) async {
    // if(updateController.text.isNotEmpty){
    //   await numbers[index] = updateController.text;
    // }
    await numbers.putAt(
        index, Contacts(name: nameController.text, number: int.tryParse(numberController.text) ?? 0));

    // await numbers.put('name', Contacts(name: 'Aelina', number: 0500447744));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: numbers.listenable(),
            builder: (context, Box<Contacts> data, _) {
              if (data.isEmpty) {
                return const Center(child: Text('no data'));
              }
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final _num = data.getAt(index);
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Color.fromRGBO(
                            255,
                            ((index + 1) * 40) % 256,
                            ((index + 1) * 70) % 256,
                            ((index + 1) * 90) % 256),
                        child: Text(
                          _num!.name.substring(0, 1),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text(_num!.name),
                      subtitle: Text('0${_num.number}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  nameController.text = tasks[index];
                                  numberController.text = tasks[index];
                                  return AlertDialog(
                                    title:
                                        textField(controller: nameController),
                                    content:
                                        textField(controller: numberController),
                                    actions: [
                                      buttonWidget(text: 'no', onPressed: (){
                                        Navigator.pop(context);
                                      },),
                                      buttonWidget(text: 'update', onPressed: (){
                                        update(index);
                                        Navigator.pop(context);
                                      })
                                    ],
                                  );
                                },
                              );

                            },
                            icon: const Icon(Icons.create),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.call),
                          ),
                          IconButton(
                            onPressed: () {
                              showDialog(context: context, builder: (context){
                                return AlertDialog(
                                  actionsAlignment: MainAxisAlignment.center,
                                  actions: [
                                    buttonWidget(text: 'no', onPressed: (){
                                      Navigator.pop(context);
                                    }),
                                    buttonWidget(text: 'delete', onPressed: (){
                                      delete();
                                    }),
                                  ],
                                );
                              });

                            },
                            icon: const Icon(Icons.delete),
                          ),
                        ],
                      ),
                    );
                  });
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddScreen(),
            ),
          );
        },
      ),
    );
  }

  Widget textField({TextEditingController? controller}) {
    return TextField(
      controller: controller,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget buttonWidget({required String text, required Function() onPressed}) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text),
    );
  }
}
