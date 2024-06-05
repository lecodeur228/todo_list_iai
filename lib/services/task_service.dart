import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list_iai/models/task.dart';

class TaskService {



  static List<Task> tasks = [];

 static  Future<bool> getTaskList()async{
    final SharedPreferences pref = await SharedPreferences.getInstance();
    tasks = pref.getStringList('tasks')!.map((task) => Task.fromJson(jsonDecode(task))).toList();
     return true;
  }


  static Future saveTask(Task task) async {
    tasks.add(task);
    final SharedPreferences pref = await SharedPreferences.getInstance();

    pref.setStringList(
        'tasks', tasks.map((task) => jsonEncode(task.toJson())).toList());
  }
}
