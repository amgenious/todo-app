import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/data/database.dart';
import 'package:todo_app/util/dialog_box.dart';
import 'package:todo_app/util/todo_tile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _myBox = Hive.box('mybox');
  TodoDataBase db = TodoDataBase();

  @override
  void initState() {
    if (_myBox.get("TODOLIST") == null) {
      db.createInitialData();
    } else {
      db.loadData();
    }
    super.initState();
  }

  void checkBoxChanged(bool? value, int index) {
    setState(() {
      db.todoList[index][1] = !db.todoList[index][1];
    });
    db.updateDatabase();
  }

  final _controller = TextEditingController();
  void savedNewTask() {
    setState(() {
      db.todoList.add(
        [_controller.text, false],
      );
      _controller.clear();
    });
    Navigator.of(context).pop();
    db.updateDatabase();
  }

  void delete(int index) {
    setState(() {
      db.todoList.removeAt(index);
    });
    db.updateDatabase();
  }

  void createNewTask() {
    showDialog(
      context: context,
      builder: (context) {
        return DialogBoxPage(
          controller: _controller,
          onCancel: () => Navigator.of(context).pop(),
          onSave: savedNewTask,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        title: const Text(
          'TODO',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView.builder(
          itemCount: db.todoList.length,
          itemBuilder: (context, index) {
            return TodoTile(
              taskName: db.todoList[index][0],
              taskCompleted: db.todoList[index][1],
              onChanged: (value) => checkBoxChanged(value, index),
              deletetask: (context) => delete(index),
            );
          }),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        onPressed: createNewTask,
        child: const Icon(Icons.add),
      ), // ,
    );
  }
}
