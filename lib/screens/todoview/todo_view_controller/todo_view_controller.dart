import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../models/todo_model.dart';


class TodoController extends GetxController {
  var todos = <Todo>[].obs;

  void addTodo(String title, String description, DateTime dueDate) {
    todos.add(Todo(
      title: title,
      description: description,
      dueDate: dueDate,
    ));
  }

  void removeTodoAt(int index) {
    todos.removeAt(index);
  }

  void markAsComplete(int index) {
    todos[index].isCompleted = true;
    todos.refresh();
  }

  void checkDueDates() {
    var today = DateTime.now();
    for (var todo in todos) {
      if (todo.dueDate.difference(today).inDays == 0) {
        Get.snackbar('Reminder', 'Task "${todo.title}" is due today!');
      }
    }
  }


  void showAddTodoDialog(BuildContext context) {
    String title = '';
    String description = '';
    DateTime dueDate = DateTime.now();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add To-Do'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) => title = value,
                decoration: InputDecoration(labelText: 'Title'),
              ),
              TextField(
                onChanged: (value) => description = value,
                decoration: InputDecoration(labelText: 'Description'),
              ),
              ElevatedButton(
                onPressed: () async {
                  dueDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                  ) ?? DateTime.now();
                },
                child: Text('Select Due Date'),
              )
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                addTodo(title, description, dueDate);
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
          ],
        );
      },
    );
  }
}
