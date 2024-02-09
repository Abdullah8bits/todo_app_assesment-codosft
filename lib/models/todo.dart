import '../utility/data_store.dart';

class Todos {
  late int? id;
  late String name;

  Todos({
    this.id,
    required this.name,
  });

  // Convert Student Object to Map

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      colId: id,
      colName: name,
    };

    return map;
  }

  // Convert Map to Student Object
  // Named Constructor

  Todos.fromMap(Map<String, dynamic> map) {
    id = map[colId];
    name = map[colName];
  }
}
