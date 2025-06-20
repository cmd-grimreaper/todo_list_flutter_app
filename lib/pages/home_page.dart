import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todolist/data/database.dart';
import 'package:todolist/pages/dialog_box.dart';
import 'package:todolist/pages/todo_tile.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  final Box myBox;

  const HomePage({super.key, required this.myBox});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late ToDoDataBase database;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    database = ToDoDataBase(widget.myBox);

    if (widget.myBox.get("TODOLIST") == null) {
      database.createInitialData();
    } else {
      database.loadData();
    }
  }

  void saveNewTask() {
    setState(() {
      database.toDoList.add([_controller.text, false]);
      _controller.clear();
    });
    database.updateDataBase();
    Navigator.of(context).pop();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBox(
          controller: _controller,
          onSave: saveNewTask,
          onCancel: () {
            _controller.clear();
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      database.toDoList[index][1] = value;
    });
    database.updateDataBase();
  }

  void deleteTask(int index) {
    setState(() {
      database.toDoList.removeAt(index);
    });
    database.updateDataBase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 17, 238, 201),
      appBar: AppBar(
        centerTitle: true,
        title:  Text('ToDoList',
          style: GoogleFonts.poppins(
    textStyle: const TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    color: Colors.white,
        ),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 22, 175, 175),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewTask,
        child: const Icon(Icons.add),
        backgroundColor: Colors.cyan,
      ),
      body: ListView.builder(
        itemCount: database.toDoList.length,
        itemBuilder: (context, index) {
          return TodoTile(
            taskName: database.toDoList[index][0],
            taskCompleted: database.toDoList[index][1],
            onChanged: (value) => checkBoxChanged(value, index),
            deleteFunction: (context) => deleteTask(index),
          );
        },
      ),
    );
  }
}
