import 'dart:async';

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
  List<TodoModel> todoList = [];
  final User? _user = FirebaseAuth.instance.currentUser;
  final DatabaseReference _databaseReference =
      FirebaseDatabase.instance.reference().child("Todo");

  Future<void> getData() async {
    _databaseReference.onValue.listen((event) {
      DataSnapshot snapshot = event.snapshot;
      if (snapshot.value != null) {
        Map<dynamic, dynamic> data = snapshot.value as Map<dynamic, dynamic>;
        List<TodoModel> tempList = [];
        data.forEach((key, value) {
          TodoModel todo = TodoModel.fromMap(Map<String, dynamic>.from(value));
          tempList.add(todo);
        });
        setState(() {
          todoList = tempList;
        });
      }
    });
  }

  Future<void> deleteTask(String taskId) async {
    _databaseReference.child(taskId).remove().then((_) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("Task Deleted")));
    }).catchError((onError) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Error {$onError}")));
    });
  }

  Future<void> addTask(TodoModel item) async {
    DatabaseReference newTaskRef =
        _databaseReference.push(); // Generate a unique key
    String taskKey = newTaskRef.key!; // Get the key

    TodoModel newItem =
        item.copyWith(taskId: taskKey); // Store the key in model

    newTaskRef.set(newItem.toMap()).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Task Added")),
      );
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to add task: $error")),
      );
    });
  }

  Future<void> updateTask(
      String taskId, Map<String, dynamic> updateData) async {
    _databaseReference.child(taskId).update(updateData).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Task Updated")),
      );
    }).catchError((onError) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to add task: $onError")),
      );
    });
  }

  void _updateTaskDialog(BuildContext context, TodoModel todo) {
    TextEditingController _taskController =
        TextEditingController(text: todo.task);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Update Task",
              textAlign: TextAlign.center,
            ),
            content: TextField(
              controller: _taskController,
              decoration: const InputDecoration(hintText: "Enter Task"),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    updateTask(
                        todo.taskId, {"task": _taskController.text.trim()});
                    Navigator.pop(context);
                  },
                  child: const Text("Update"))
            ],
          );
        });
  }

  void _addTaskDialog(BuildContext context) {
    TextEditingController _taskController = TextEditingController();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text(
              "Add Task",
              textAlign: TextAlign.center,
            ),
            content: TextField(
              controller: _taskController,
              decoration: const InputDecoration(
                hintText: "Enter your task",
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    TodoModel item = TodoModel(
                        task: _taskController.text,
                        userId: _user!.uid,
                        taskId: "");
                    addTask(item);
                    Navigator.of(context).pop();
                  },
                  child: const Text("Add"))
            ],
          );
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _addTaskDialog(context);
        },
        backgroundColor: Colors.blueAccent[200],
        child: const Icon(Icons.add, color: Colors.black),
      ),
      appBar: AppBar(
        title: const Text('Todo'),
        backgroundColor: Colors.blueAccent[200],
      ),
      body: SafeArea(
        child: todoList.isEmpty
            ? const Center(
                child: Text(
                  "No Task Avaliable",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              )
            : ListView.builder(
                itemCount: todoList.length,
                itemBuilder: ((context, index) {
                  return Dismissible(
                    background: Container(
                      margin:
                          const EdgeInsets.only(top: 10, right: 10, left: 10),
                      padding: const EdgeInsets.only(right: 20),
                      decoration: BoxDecoration(
                          color: Colors.red[400],
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(10)),
                      alignment: Alignment.centerRight,
                      child: const Icon(
                        Icons.delete,
                        color: Colors.white,
                      ),
                    ),
                    onDismissed: (directation) {
                      setState(() {
                        deleteTask(todoList[index].taskId);
                        todoList.removeAt(index);
                      });
                    },
                    key: Key(todoList[index].task),
                    child: Item(
                        todo: todoList[index],
                        onTap: (TodoModel todo) {
                          _updateTaskDialog(context, todo);
                        }),
                  );
                })),
      ),
    );
  }
}
