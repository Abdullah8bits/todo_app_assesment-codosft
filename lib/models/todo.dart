import '../utility/data_store.dart';

class Todos {
  late int? id;
  late String name;

  late String description;
  late String befdate;

  Todos({
    this.id,
    required this.name,
    required this.description,
    required this.befdate,
  });

  // Convert Student Object to Map

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {
      colId: id,
      colName: name,
      colDescription: description,
      colbefdate: befdate,
    };

    return map;
  }

  // Convert Map to Student Object
  // Named Constructor

  Todos.fromMap(Map<String, dynamic> map) {
    id = map[colId];
    name = map[colName];

    description = map[colDescription];
    befdate = map[colbefdate];
  }
}
