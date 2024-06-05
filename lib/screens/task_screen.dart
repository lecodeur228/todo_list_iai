import 'package:flutter/material.dart';
import 'package:todo_list_iai/models/task.dart';

import 'package:todo_list_iai/screens/add_task_screen.dart';
import 'package:todo_list_iai/services/task_service.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  //declaration de la variable pref qui va recuperer le shared preferences
  // late SharedPreferences pref;
  // late Future<int> _counter;

  // Future<void> incrementCounter() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   final int counter = (prefs.getInt('counter') ?? 0) + 1;

  //   setState(() {
  //     _counter = prefs.setInt('counter', counter).then((bool success) {
  //       return counter;
  //     });
  //   });
  // }

  // @override
  // // fonction qui s'execute au lancement de la page
  // void initState() {
  //   super.initState();
  //   SharedPreferences.getInstance().then((SharedPreferences prefs) {
  //     print("intance est recuperer ");
  //     pref = prefs;
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TASKS"),
        centerTitle: true,
      ),
      body: FutureBuilder<bool>(

          future: TaskService.getTaskList(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return ListView.builder(
              itemCount: TaskService.tasks.length,
              itemBuilder: (BuildContext context, int index) {
                Task item = TaskService.tasks[index];
                return Container(
                  width: double.infinity,
                  height: 200,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  padding: const EdgeInsets.all(20),
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        spreadRadius: 2,
                        offset: Offset(0, 2),
                      ),
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            item.titre,
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            item.date.toString(),
                            style: const TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        item.description,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.check,
                                color: Colors.green,
                                size: 30,
                              )),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                                size: 30,
                              ))
                        ],
                      )
                    ],
                  ),
                );
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          // naviger ver autre page
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddTaskScreen())).then((value) {
                setState(() {
                  
                });
              });
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }
}
