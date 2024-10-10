// lib/views/add_task_view.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../todoview/todo_view_controller/todo_view_controller.dart';


class AddTaskView extends StatelessWidget {
  final TodoController todoController = Get.find();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime dueDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Task'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Task Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Task Description'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                dueDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                ) ?? DateTime.now();
              },
              child: Text('Select Due Date (${DateFormat.yMMMd().format(dueDate)})'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                todoController.addTodo(
                  titleController.text,
                  descriptionController.text,
                  dueDate,
                );
                Get.back();
              },
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
