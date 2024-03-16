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

  final textController = TextEditingController();

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
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              actionsPadding: EdgeInsets.all(10),
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5)),
              title: Text(
                "Add a todo",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: TextField(
                autofocus: true,
                onSubmitted: (value) {
                  if (value != "") {
                    setState(() {
                      todos.insert(0, Todo(task: value));
                    });
                    textController.text = "";
                  }

                  Navigator.pop(context);
                },
                controller: textController,
                decoration: InputDecoration(
                  hintText: "Type your todo",
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: Colors.blue,
                      width: 2,
                    ),
                  ),
                ),
              ),
              actions: [
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.blue,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(13),
                        )),
                    onPressed: () {
                      textController.text = "";
                      Navigator.pop(context);
                    },
                    child: Text("Cancel")),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(13))),
                    onPressed: () {
                      if (textController.text != "") {
                        setState(() {
                          todos.insert(0, Todo(task: textController.text));
                        });
                      }
                      Navigator.pop(context);
                    },
                    child: const Text("Add"))
              ],
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
