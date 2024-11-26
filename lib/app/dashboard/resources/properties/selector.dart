class Selector {
  late String type;
  late Map<String, dynamic> details;

  Selector.fromMap(Map<String, dynamic> data) {
    details = {};
    for (var e in data.entries) {
      type = e.key;
      if (e.value is Map<String, dynamic>) {
        for (var f in e.value.entries) {
          details[f.value] = f.key;
        }
      } else {
        details[e.value] = e.key;
      }
    }
  }
}
