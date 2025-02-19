import 'package:flutter/material.dart';
import 'package:todo/models/todo_model.dart';

class Item extends StatefulWidget {
  final TodoModel todo;
  final Function(TodoModel item) onTap;

  const Item({super.key, required this.todo, required this.onTap});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap(widget.todo);
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.blueAccent[100],
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(10),
        ),
        margin: const EdgeInsets.only(top: 10, right: 10, left: 10),
        child: Row(
          children: [
            Checkbox(
                value: _value,
                onChanged: (value) {
                  setState(() {
                    _value = value!;
                  });
                }),
            Text(
              widget.todo.task,
              style: const TextStyle(color: Colors.black, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
