import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/widgets/list_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final User? _user = FirebaseAuth.instance.currentUser;
  DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child("Todo");

  Future<void> addTask(TodoModel item) async {
    item.
    _databaseReference.push().set(item.toMap()).then((value) {
      print("Task Added");
    }).catchError((error) {
      print("Failed to add task: $error");
    });
  }

  void _addTaskDialogue(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Add Task",
              textAlign: TextAlign.center,
            ),
            content: const TextField(
              decoration: InputDecoration(
                hintText: "Enter your task",
              ),
            ),
            actions: [TextButton(onPressed: () {}, child: const Text("Add"))],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTaskDialogue(context);
        },
        backgroundColor: Colors.blueAccent[200],
        child: const Icon(Icons.add, color: Colors.black),
      ),
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
