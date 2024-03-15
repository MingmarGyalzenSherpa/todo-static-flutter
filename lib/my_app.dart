import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:todo_app/todo.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyApp> {
  List<Todo> todos = [
    Todo(task: "go home", isCompleted: true),
    Todo(task: "Buy potato")
  ];
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[400],
        title: const Text(
          "Todo Manager",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.all(20),
          child: ListView.builder(
            itemBuilder: (context, int index) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                          value: todos[index].isCompleted,
                          activeColor: Colors.red,
                          onChanged: (bool? value) {
                            setState(() {
                              todos[index].isCompleted = value!;
                            });
                          }),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(
                        todos[index].task,
                        style: TextStyle(
                          decoration: todos[index].isCompleted
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: todos[index].isCompleted
                              ? Colors.black45
                              : Colors.black,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        //convert the List<Todo> to map
                        //convert it to entries
                        //map through the entry
                        //return only the todo thats not deleted else null
                        //filter non-null value
                        //convert it from iterable to list
                        todos = todos
                            .asMap()
                            .entries
                            .map((entry) {
                              var todo = entry.value;
                              if (entry.key != index) {
                                return Todo(
                                    task: todo.task,
                                    isCompleted: todo.isCompleted);
                              } else {
                                return null;
                              }
                            })
                            .whereType<Todo>()
                            .toList();
                      });
                    },
                  )
                ],
              );
            },
            itemCount: todos.length,
          )),
      floatingActionButton: ClipOval(
        child: FloatingActionButton(
          onPressed: () {
            AlertDialog alertDialog = AlertDialog(
              title: Text("Change?"),
              content: ElevatedButton(
                child: Text('yes'),
                onPressed: () {
                  setState(() {
                    isChecked = !isChecked;
                  });
                  Navigator.pop(context);
                },
              ),
            );

            showDialog(context: context, builder: (context) => alertDialog);
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          ),
          backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}
