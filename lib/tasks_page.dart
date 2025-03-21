import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:vertex/main_layout.dart';

class TasksPage extends StatefulWidget {
  @override
  _TasksPageState createState() => _TasksPageState();
}

class _TasksPageState extends State<TasksPage> {
  TextEditingController _taskController = TextEditingController();
  List<String> _tasks = [];

  @override
  void initState() {
    super.initState();
    _loadTasks();
  }

  void _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? tasksString = prefs.getString('tasks');
    if (tasksString != null) {
      setState(() {
        _tasks = List<String>.from(json.decode(tasksString));
      });
    }
  }


  void _saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('tasks', json.encode(_tasks));
  }

  void _addTask() {
    if (_taskController.text.isNotEmpty) {
      setState(() {
        _tasks.add(_taskController.text);
        _taskController.clear();
        _saveTasks();
      });
    }
  }

  void _removeTask(int index) {
    setState(() {
      _tasks.removeAt(index);
      _saveTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _taskController,
                  decoration: InputDecoration(
                    labelText: "Nova Tarefa",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              SizedBox(width: 10),
              ElevatedButton(
                onPressed: _addTask,
                child: Text("Adicionar"),
              ),
            ],
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: _tasks.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(_tasks[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _removeTask(index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
