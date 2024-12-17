import 'package:flutter/material.dart';

class Lesson1 extends StatefulWidget {
  const Lesson1({super.key});

  @override
  State<Lesson1> createState() => _Lesson1State();
}

class _Lesson1State extends State<Lesson1> {

  List<String> books = ['vino is aduvanchikov', 'djeck london', 'plaha', 'djamilya'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: books.length,
          itemBuilder: (context,index){
        return Text(books[index]);
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          setState(() {
            books.add('new book');
          });
        },

      ),
    );
  }
}
