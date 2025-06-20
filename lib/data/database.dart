import 'package:hive_flutter/hive_flutter.dart';

class ToDoDataBase {
  final Box box;
  List toDoList = [];

  ToDoDataBase(this.box);

  void createInitialData() {
    toDoList = [
      ["Make a Tutorial", false],
      ["Go for a walk", false],
    ];
    updateDataBase();
  }

  void loadData() {
    toDoList = box.get("TODOLIST") ?? [];
  }

  void updateDataBase() {
    box.put("TODOLIST", toDoList);
  }
}
