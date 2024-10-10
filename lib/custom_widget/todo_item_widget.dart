// lib/widgets/todo_item_widget.dart

import 'package:flutter/material.dart';
import '../models/todo_model.dart';

class TodoItemWidget extends StatelessWidget {
  final Todo todo;
  final VoidCallback onDelete;
  final VoidCallback onComplete;

  TodoItemWidget({
    required this.todo,
    required this.onDelete,
    required this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        todo.title,
        style: TextStyle(
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null),
      ),
      subtitle: Text(todo.description),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: Icon(Icons.check),
            onPressed: onComplete,
          ),
          IconButton(
            icon: Icon(Icons.delete),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}
