import 'package:flutter/material.dart';
import 'package:todo_app/models/todo.dart';

class TodoCard extends StatefulWidget {
  final Todos todo;
  final VoidCallback onDelete;

  const TodoCard({
    super.key,
    required this.todo,
    required this.onDelete,
  });

  @override
  State<TodoCard> createState() => _StudentCardState();
}

class _StudentCardState extends State<TodoCard> {
  var done = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Container(
        height: 80,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  setState(() {
                    done = !done;
                  });
                },
                icon: done == true
                    ? Icon(Icons.check_box_outline_blank_outlined)
                    : Icon(Icons.check_box)),
            Text(
              widget.todo.name,
              style: TextStyle(
                  decoration: done == false
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                  fontSize: 20),
            ),
            IconButton(onPressed: widget.onDelete, icon: Icon(Icons.delete))
          ],
        ),
      ),
    );
  }
}
