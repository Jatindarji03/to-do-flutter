import 'package:flutter/material.dart';
import 'package:todo/models/todo_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo'),
        backgroundColor: Colors.blueAccent[200],
      ),
      body: Center(
        child: ListView.builder(
            itemCount: DataList.list.length,
            itemBuilder: ((context, index) {
              return Item(todo: DataList.list[index]);
            })),
      ),
    );
  }
}

class Item extends StatefulWidget {
  final TodoModel todo;
  const Item({super.key, required this.todo});

  @override
  State<Item> createState() => _ItemState();
}

class _ItemState extends State<Item> {
  bool _value = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blueAccent[100],
      margin: const EdgeInsets.all(10),
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
            style: TextStyle(color: Colors.black, fontSize: 20),
          ),
        ],
      ),
    );
  }
}
