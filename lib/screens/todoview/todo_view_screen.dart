import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../custom_widget/todo_item_widget.dart';
import '../../routes/app_routes.dart';
import 'todo_view_controller/todo_view_controller.dart';


class TodoView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TodoController>(builder: (todoController)
    {
      return Scaffold(
        appBar: AppBar(
          title: Text('To-Do List'),
        ),
        body: Obx(() {
          return ListView.builder(
            itemCount: todoController.todos.length,
            itemBuilder: (context, index) {
              return TodoItemWidget(
                todo: todoController.todos[index],
                onDelete: () => todoController.removeTodoAt(index),
                onComplete: () => todoController.markAsComplete(index),
              );
            },
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
             Get.toNamed(AppRoutes.AddTaskView);
          },
          child: Icon(Icons.add),
        ),
      );
    });
  }

}
