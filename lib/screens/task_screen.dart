import 'package:flutter/material.dart';
import 'package:todo_list_iai/models/task.dart';

import 'package:todo_list_iai/screens/add_task_screen.dart';
import 'package:todo_list_iai/services/task_service.dart';

import '../widgets/task_widget.dart';

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
                return TaskWidget(item: item);
              },
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blueAccent,
        onPressed: () {
          // naviger ver autre page
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>  AddTaskScreen())).then((value) {
            setState(() {});
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
