import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';

class LocalStorage extends StatefulWidget {

  const LocalStorage({super.key});

  @override
  State<LocalStorage> createState() => _LocalStorageState();
}

class _LocalStorageState extends State<LocalStorage> {
  final Box<String> books = Hive.box<String>('books');
TextEditingController titleController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: titleController,
          decoration: InputDecoration(
            border: OutlineInputBorder(

            )
          )
        ),
      ),
      body: ValueListenableBuilder(
          valueListenable: books.listenable(),
          builder: (context, Box<String> data, _) {
            if (data.isEmpty) {
              return const Center(
                child: Text('данных нету'),
              );
            }
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                final book = data.getAt(index);
                return ListTile(
                  title: Text(book!),
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
         if(titleController.text.isNotEmpty){
           setState(() {
             books.add(titleController.text);
           });
         }
        },
      ),
    );
  }
}
