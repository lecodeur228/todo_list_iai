

import 'dart:convert';

class Task {
  String titre;
  String description;
  DateTime date;
  // le constructor
  Task({required this.titre, required this.description, required this.date});

  //

  factory Task.fromJson(Map<String, dynamic> task) {
    return Task(
      titre: task['title'],
      description: task['description'],
      date: DateTime.parse(task['date']),
    );
  } 
  
  
  Map<String, dynamic> toJson() {
    return {
      'title' : titre,
      'description' : description,
      'date' : date.toString(),
    };
  }

}
