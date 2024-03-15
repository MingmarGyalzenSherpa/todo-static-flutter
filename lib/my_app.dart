import 'package:flutter/material.dart';
import 'package:todo_app/todo.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyApp> {
  List<Todo> todos = [
    Todo(id: 1, task: "go home"),
    Todo(id: 2, task: "Buy potato")
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
                          onChanged: (bool? value) {}),
                      SizedBox(
                        width: 20,
                      ),
                      Text(todos[index].task),
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    color: Colors.red,
                    onPressed: () {},
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
