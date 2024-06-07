import 'package:flutter/material.dart';
import 'package:todo_list_iai/models/task.dart';
import 'package:todo_list_iai/screens/add_task_screen.dart';
import 'package:intl/intl.dart';

class TaskWidget extends StatelessWidget {
  const TaskWidget({
    super.key,
    required this.item,
  });

  final Task item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPress: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: ((context) => AddTaskScreen(
                      task: item,
                    ))));
      },
      child: Container(
        width: double.infinity,
        height: 200,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 7,
              spreadRadius: 4,
              offset: Offset(0, 3),
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
                  "${DateFormat.yMd(item.date.toString())}",
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
            const SizedBox(
              height: 10,
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  getDuration(item.date)["isNegative"]
                      ? "il y'a : ${getDuration(item.date)["duration"]} "
                      : "dans : ${getDuration(item.date)["duration"]} ",
                  style: const TextStyle(
                      color: Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.w500),
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 30,
                    )),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.check,
                      color: Colors.green,
                      size: 30,
                    )),
              ],
            )
          ],
        ),
      ),
    );
  }

  Map getDuration(DateTime time) {
    Duration duration = time.difference(DateTime.now());
    return duration.isNegative
        ? {
            "isNegative": true,
            "duration": duration,
          }
        : {
            "isNegative": true,
            "duration": duration,
          };
  }
}
