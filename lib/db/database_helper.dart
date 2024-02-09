import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_app/models/todo.dart';
import 'package:todo_app/utility/data_store.dart';

class DatabaseHelper {
  // database
  DatabaseHelper._privateConstructor(); // Name constructor to create instance of database
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;

  // getter for database

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    // Get the directory path for both Android and iOS
    // to store database

    Directory directory = await getApplicationDocumentsDirectory();
    String path = '${directory.path}/todos.db';

    // open/ create database at a given path
    var todosDatabase = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );

    return todosDatabase;
  }

  void _createDb(Database db, int newVersion) async {
    await db.execute('''Create TABLE $tableTodos (
                  $colId INTEGER PRIMARY KEY AUTOINCREMENT,
                  
                   )
    
    ''');
  }

  // insert
  Future<int> insertTodo(Todos todo) async {
    // add dog to table

    Database db = await instance.database;

    String insertQuery = '''
    INSERT INTO $tableTodos
      ( $colName)
      VALUES (?)
    ''';

    int result = await db.rawInsert(insertQuery, [todo.name]);

    return result;
  }

  // read operation
  Future<List<Todos>> getAllTodos() async {
    List<Todos> todos = [];

    Database db = await instance.database;

    // read data from table
    List<Map<String, dynamic>> listMap = await db.query('$tableTodos');

    for (var todoMap in listMap) {
      Todos todo = Todos.fromMap(todoMap);
      todos.add(todo);
    }

    return todos;
  }

  // delete
  Future<int> deleteTodos(int id) async {
    Database db = await instance.database;
    int result = await db.delete('$tableTodos', where: 'id=?', whereArgs: [id]);
    return result;
  }

  // read for search operation
  Future<List<Todos>> searchTodos({required String name}) async {
    List<Todos> todo = [];

    Database db = await instance.database;

    // read data from table
    List<Map<String, dynamic>> listMap = await db
        .query('$tableTodos', where: 'name like ?', whereArgs: ['%$name%']);

    for (var dogMap in listMap) {
      Todos todos = Todos.fromMap(dogMap);
      todo.add(todos);
    }

    return todo;
  }
}
