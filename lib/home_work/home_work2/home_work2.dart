import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:hive_lessons/home_work/home_work2/add_workers.dart';

import 'employee.dart';

class HomeWork2 extends StatefulWidget {
  const HomeWork2({super.key});

  @override
  State<HomeWork2> createState() => _HomeWork2State();
}

class _HomeWork2State extends State<HomeWork2> {
  final Box<Workers> workers = Hive.box<Workers>('workers');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ValueListenableBuilder(
            valueListenable: workers.listenable(),
            builder: (context, Box<Workers> data, _) {
              if (data.isEmpty) {
                return const Center(
                  child: Text('no data'),
                );
              }
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    final _info = data.getAt(index);
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 30,
                        backgroundColor: Color.fromRGBO(
                            255,
                            ((index + 1) * 40) % 256,
                            ((index + 1) * 70) % 256,
                            ((index + 1) * 90) % 256),
                        child: Text(
                          _info!.name.substring(0, 1),
                          style: const TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),
                      title: Text('${_info.name} ${_info.surname}'),
                      subtitle: Text('${_info.experience}- years of experience'),
                      trailing: Text('\$${_info.salary}'),
                    );
                  });
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddWorkers(),
            ),
          );
        },
      ),
    );
  }
}
