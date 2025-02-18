// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class DataList {
  static List<TodoModel> list = [
    TodoModel(task: "Do Work On Android"),
    TodoModel(task: "Do Work On DSA"),
    TodoModel(task: "Do Work On Flutter"),
  ];
}

class TodoModel {
  final String task;
  TodoModel({
    required this.task,
  });

  TodoModel copyWith({
    String? task,
  }) {
    return TodoModel(
      task: task ?? this.task,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'task': task,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      task: map['task'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) => TodoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TodoModel(task: $task)';

  @override
  bool operator ==(covariant TodoModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.task == task;
  }

  @override
  int get hashCode => task.hashCode;
}
