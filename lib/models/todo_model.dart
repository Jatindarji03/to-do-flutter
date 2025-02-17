class DataList {
  static List<TodoModel> list = [
    TodoModel(task: "Do Work On Android"),
    TodoModel(task: "Do Work On DSA"),
    TodoModel(task: "Do Work On Flutter"),
  ];
}

class TodoModel {
  final String task;
  TodoModel({required this.task});
}
