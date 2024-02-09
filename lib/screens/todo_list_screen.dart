import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todo_app/db/database_helper.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/screens/add_todos_screen.dart';
import 'package:todo_app/widgets/todo_card_widget.dart';

class TodosListScreen extends StatefulWidget {
  const TodosListScreen({Key? key}) : super(key: key);

  @override
  State<TodosListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<TodosListScreen> {
  late TextEditingController nameController;

  @override
  void initState() {
    nameController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Todos',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTodosScreen(),
              ));
        },
        child: Icon(Icons.add),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: TextField(
              onChanged: (value) {
                _searchTodos();
              },
              controller: nameController,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Todos>>(
              future: DatabaseHelper.instance
                  .searchTodos(name: nameController.text.trim()),
              builder:
                  (BuildContext context, AsyncSnapshot<List<Todos>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No students found'));
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      Todos todo = snapshot.data![index];
                      return TodoCard(
                        todo: todo,
                        onDelete: () => _showDeleteConfirmationDialog(todo),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  void _searchTodos() {
    String name = nameController.text.trim();
    if (name.isEmpty) {
      setState(() {
        FutureBuilder<List<Todos>>(
          future: DatabaseHelper.instance.getAllTodos(),
          builder: (BuildContext context, AsyncSnapshot<List<Todos>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No students found'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  Todos todo = snapshot.data![index];
                  return TodoCard(
                    todo: todo,
                    onDelete: () => _showDeleteConfirmationDialog(todo),
                  );
                },
              );
            }
          },
        );
      });
    } else {
      setState(() {
        String name = nameController.text.trim();

        if (name.isEmpty) {
          Fluttertoast.showToast(msg: 'Please provide name to search');
        } else {
          DatabaseHelper.instance.searchTodos(name: name);
          setState(() {});
        }
      });
    }
  }

  void _showDeleteConfirmationDialog(Todos todo) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Color.fromARGB(255, 97, 97, 97),
          title: Text(
            'Confirmation',
            style: TextStyle(color: Colors.white),
          ),
          content: Text(
            'Are you sure you want to delete?',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'No',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () async {
                Navigator.pop(context);
                int result =
                    await DatabaseHelper.instance.deleteTodos(todo.id!);
                if (result > 0) {
                  Fluttertoast.showToast(msg: 'Deleted');
                  setState(() {});
                } else {
                  Fluttertoast.showToast(msg: 'Failed');
                }
              },
              child: Text(
                'Yes',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
