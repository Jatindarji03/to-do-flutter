// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class TodoModel {
  final String task;
  final String userId; // Added userId
  final String taskId; // Added taskId

  TodoModel({
    required this.task,
    required this.userId,
    required this.taskId,
  });
  

  TodoModel copyWith({
    String? task,
    String? userId,
    String? taskId,
  }) {
    return TodoModel(
      task: task ?? this.task,
      userId: userId ?? this.userId,
      taskId: taskId ?? this.taskId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'task': task,
      'userId': userId,
      'taskId': taskId,
    };
  }

  factory TodoModel.fromMap(Map<String, dynamic> map) {
    return TodoModel(
      task: map['task'] as String,
      userId: map['userId'] as String,
      taskId: map['taskId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory TodoModel.fromJson(String source) => TodoModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'TodoModel(task: $task, userId: $userId, taskId: $taskId)';

  @override
  bool operator ==(covariant TodoModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.task == task &&
      other.userId == userId &&
      other.taskId == taskId;
  }

  @override
  int get hashCode => task.hashCode ^ userId.hashCode ^ taskId.hashCode;
}
