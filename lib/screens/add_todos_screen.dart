import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/db/database_helper.dart';
import 'package:todo_app/models/todo.dart';

class AddTodosScreen extends StatefulWidget {
  const AddTodosScreen({Key? key}) : super(key: key);

  @override
  State<AddTodosScreen> createState() => _AddTodosScreenState();
}

class _AddTodosScreenState extends State<AddTodosScreen> {
  final _formKey = GlobalKey<FormState>();

  late String name, description, completeBefore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text('Add Todo'),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a name';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    name = value!;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Description',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    description = value!;
                  },
                ),
                SizedBox(height: 16),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Complete Before',
                    hintText: 'YYYY-MM-DD',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a completion date';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    completeBefore = value!;
                  },
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.black),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();

                      final todo = Todos(
                        name: name,
                        description: description,
                        befdate: completeBefore,
                      );

                      final result =
                          await DatabaseHelper.instance.insertTodo(todo);

                      if (result > 0) {
                        Fluttertoast.showToast(
                          msg: 'Todo added successfully',
                          backgroundColor: Colors.green,
                        );
                        Navigator.of(context).pop();
                      } else {
                        Fluttertoast.showToast(
                          msg: 'Failed to add todo',
                          backgroundColor: Colors.red,
                        );
                      }
                    }
                  },
                  child: Text(
                    'Add Todo',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
