import 'package:flutter/material.dart';
import 'package:todo/models/todo_model.dart';

class CustomDialog extends StatefulWidget {
  final TodoModel? todo; // Null when adding a new task
  final Function(String task) onSubmit; // Callback for submit
  const CustomDialog({super.key, this.todo, required this.onSubmit});

  @override
  State<CustomDialog> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog> {
  late TextEditingController _taskController;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _taskController = TextEditingController(text: widget.todo?.task ?? "");
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.todo == null ? "Add Task" : "Update Task"),
      content: TextField(
        controller: _taskController,
        decoration: const InputDecoration(hintText: "Enter Task"),
      ),
      actions: [
        TextButton(
            onPressed: () {
              widget.onSubmit(_taskController.text.trim());
              Navigator.pop(context);
            },
            child: Text(widget.todo == null ? "Add" : "Update"))
      ],
    );
  }
}
