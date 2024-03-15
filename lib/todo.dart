class Todo {
  final int id;
  String task;
  bool isCompleted;

  Todo({required this.id, required this.task, this.isCompleted = false});

  void changeStatus() {
    isCompleted = !isCompleted;
  }
}
