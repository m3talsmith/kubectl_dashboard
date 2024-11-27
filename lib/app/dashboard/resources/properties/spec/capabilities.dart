class Capabilities {
  late List<String> add;
  late List<String> drop;

  Capabilities.fromMap(Map<String, dynamic> data) {
    add = data['add'] as List<String>;
    drop = data['drop'] as List<String>;
  }
}
