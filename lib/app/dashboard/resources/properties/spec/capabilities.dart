class Capabilities {
  List<String>? add;
  List<String>? drop;

  Capabilities.fromMap(Map<String, dynamic> data) {
    if (data['add'] != null) {
      add = [];
      for (var e in data['add']) {
        add!.add(e);
      }
    }
    if (data['drop'] != null) {
      drop = [];
      for (var e in data['drop']) {
        drop!.add(e);
      }
    }
  }
}
